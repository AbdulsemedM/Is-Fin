import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/model/murabaha_card_model.dart';
import 'package:ifb_loan/features/loan_approval_status/model/offered_products_price_model.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/loan_status_table.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/murabaha_details_card.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/pdf_dialog.dart';
import 'package:intl/intl.dart';

class LoanApprovalStatus extends StatefulWidget {
  final String id;
  final String name;
  final String agencyPdfUrl;
  final String promisePdfUrl;
  const LoanApprovalStatus({
    super.key,
    required this.id,
    required this.name,
    required this.agencyPdfUrl,
    required this.promisePdfUrl,
  });

  @override
  State<LoanApprovalStatus> createState() => _LoanApprovalStatusState();
}

class _LoanApprovalStatusState extends State<LoanApprovalStatus> {
  var loading = false;
  var checker = false;
  List<OfferedProductsPriceModel> originalProducts = [];
  List<OfferedProductsPriceModel> myOfferedProductPrices = [];
  MurabahaCardModel? murabahaCard;

  @override
  void initState() {
    super.initState();
    context
        .read<LoanApprovalStatusBloc>()
        .add(OfferedProductsPriceFetch(id: widget.id));
    context
        .read<LoanApprovalStatusBloc>()
        .add(FetchMurabahaCard(id: widget.id));
    print(widget.promisePdfUrl);
    print(widget.agencyPdfUrl);
  }

  void compareProducts(List<OfferedProductsPriceModel> currentProducts) {
    if (originalProducts.isEmpty) {
      originalProducts = List.from(currentProducts);
      return;
    }

    bool hasChanges = false;

    if (originalProducts.length != currentProducts.length) {
      hasChanges = true;
    } else {
      for (int i = 0; i < originalProducts.length; i++) {
        if (originalProducts[i].quantity != currentProducts[i].quantity ||
            originalProducts[i].productPrice !=
                currentProducts[i].productPrice) {
          hasChanges = true;
          break;
        }
      }
    }

    setState(() => checker = hasChanges);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoanApprovalStatusBloc, LoanApprovalStatusState>(
      listener: (context, state) {
        if (state is AcceptOfferLoading) {
          setState(() => loading = true);
        } else if (state is AcceptOfferSuccess) {
          setState(() => loading = false);
          context
              .read<LoanApprovalStatusBloc>()
              .add(FetchLoanApprovalStatusList());

          Navigator.pop(context);
        } else if (state is AcceptOfferFailure) {
          setState(() => loading = false);
          displaySnack(context, state.errorMessage, Colors.red);
          Navigator.pop(context);
        }
        if (state is FetchMurabahaCardSuccess) {
          print("murabahaCard");
          print(state.murabahaCard);
          setState(() {
            murabahaCard = state.murabahaCard;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Loan Approval Status",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: BlocBuilder<LoanApprovalStatusBloc, LoanApprovalStatusState>(
          builder: (context, state) {
            if (state is OfferedProductsPriceFetchedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is OfferedProductsPriceFetchedSuccess) {
              if (originalProducts.isEmpty) {
                originalProducts = List.from(state.productList);
              }

              if (state.productList.isEmpty) {
                return const Center(
                  child: Text('No products found'),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                          'Your loan application from ${widget.name}\'s has been approved by the product owner and now it is under review by the bank\'s officials. The bank will put it\'s benefits to the product and will let you know the final offer soon.'),
                      LoanStatusTable(
                        items: state.productList,
                        onProductRemove: (product) {
                          state.productList.remove(product);
                          compareProducts(state.productList);
                        },
                        onProductQuantityChange: (product, quantity) {
                          final index = state.productList.indexOf(product);
                          if (index != -1) {
                            state.productList[index] = state.productList[index]
                                .copyWith(quantity: double.parse(quantity));
                            compareProducts(state.productList);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "ETB ${NumberFormat('#,###').format(calculateTotal(state.productList))}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   child: Text(
                      //       textAlign: TextAlign.center,
                      //       style: Theme.of(context).textTheme.bodyLarge,
                      //       "If you accept these offer from the merchant click the button bellow and the bank officials will review the loan application"),
                      // ),
                      if (murabahaCard != null)
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: MurabahaDetailsCard(
                            purchaseCost:
                                "${NumberFormat("#,###.##").format(double.parse(murabahaCard!.purchaseCost))} ETB",
                            markup:
                                "${NumberFormat("#,###.##").format(double.parse(murabahaCard!.markUp))} ETB",
                            totalPrice:
                                "${NumberFormat("#,###.##").format(double.parse(murabahaCard!.totalMurabahaPrice))} ETB",
                            duration: murabahaCard!.durationofFinancing,
                            processingFees:
                                "${NumberFormat("#,###.##").format(double.parse(murabahaCard!.processingFee))} ETB",
                          ),
                        ),

                      MyButton(
                          backgroundColor: loading
                              ? AppColors.iconColor
                              : AppColors.primaryDarkColor,
                          onPressed: loading
                              ? () {}
                              : checker
                                  ? () async {
                                      final bool? result =
                                          await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirmation"),
                                            content: const Text(
                                                "Are you sure you want to resubmit your new offer?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: const Text("No")),
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: const Text("Yes")),
                                            ],
                                          );
                                        },
                                      );
                                      if (result == true && mounted) {
                                        context
                                            .read<LoanApprovalStatusBloc>()
                                            .add(AcceptOffer(
                                                id: widget.id,
                                                status: "PENDING",
                                                productList:
                                                    state.productList));
                                      }
                                    }
                                  : () async {
                                      final bool result = await _showPdfDialog(
                                          context, widget.agencyPdfUrl);
                                      // print("result");
                                      // print(result);
                                      if (result == true && mounted) {
                                        final bool result2 =
                                            await _showPdfDialog(
                                                context, widget.promisePdfUrl);
                                        if (result2 == true && mounted) {
                                          context
                                              .read<LoanApprovalStatusBloc>()
                                              .add(AcceptOffer(
                                                  id: widget.id,
                                                  status: "APPROVED"));
                                        }
                                      }
                                    },
                          buttonText: loading
                              ? SizedBox(
                                  height: ScreenConfig.screenHeight * 0.02,
                                  width: ScreenConfig.screenHeight * 0.02,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : Text(
                                  !checker ? "Accept Offer" : "Resubmit Offer",
                                  style: TextStyle(color: Colors.white),
                                )),
                      const SizedBox(height: 16),
                      MyButton(
                          backgroundColor:
                              loading ? AppColors.iconColor : Colors.red,
                          onPressed: loading
                              ? () {}
                              : () async {
                                  final bool? result = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirmation"),
                                        content: const Text(
                                            "Are you sure you want to reject the offer?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text("No")),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text("Yes")),
                                        ],
                                      );
                                    },
                                  );
                                  if (result == true && mounted) {
                                    context.read<LoanApprovalStatusBloc>().add(
                                        AcceptOffer(
                                            id: widget.id, status: "REJECTED"));
                                  }
                                },
                          buttonText: loading
                              ? SizedBox(
                                  height: ScreenConfig.screenHeight * 0.02,
                                  width: ScreenConfig.screenHeight * 0.02,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : const Text(
                                  "Reject Offer",
                                  style: TextStyle(color: Colors.white),
                                )),
                    ],
                  ),
                ),
              );
            }

            if (state is OfferedProductsPriceFetchedFailure) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  double calculateTotal(List<OfferedProductsPriceModel> products) {
    return products.fold(
        0.0, (sum, product) => sum + (product.productPrice * product.quantity));
  }

  Future<bool> _showPdfDialog(BuildContext context, String pdfUrl) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return PdfDialog(
          pdfUrl: pdfUrl,
          onAccept: () {
            Navigator.pop(context, true);
          },
          onReject: () {
            Navigator.pop(context, false);
          },
        );
      },
    );

    return result ?? false;
  }
}
