import 'package:budget_app/components.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

bool isLoading = true;

class ExpenseViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      viewModelProvider.expensesStream();
      viewModelProvider.incomesStream();
      isLoading = false;
    }

    int totalExpense = 0;
    int totalIncome = 0;

    void calculate() {
      for (int i = 0; i < viewModelProvider.expensesAmount.length; i++) {
        totalExpense =
            totalExpense + int.parse(viewModelProvider.expensesAmount[i]);
      }
      for (int i = 0; i < viewModelProvider.incomesAmount.length; i++) {
        totalIncome =
            totalIncome + int.parse(viewModelProvider.incomesAmount[i]);
      }
    }

    calculate();

    int budgetLeft = totalIncome - totalExpense;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 180.0,
                    backgroundColor: Colors.white,
                    child: Image(
                      height: 100.0,
                      image: AssetImage(
                        "assets/logo.png",
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                onPressed: () async {
                  await viewModelProvider.logout();
                },
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 50.0,
                minWidth: 200.0,
                color: Colors.black,
                child: OpenSans(
                  text: "Logout",
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async => await launchUrl(
                        Uri.parse("https://www.instagram.com/narendramodi")),
                    icon: SvgPicture.asset(
                      "assets/instagram.svg",
                      color: Colors.black,
                      width: 35.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async => await launchUrl(
                        Uri.parse("https://www.twitter.com/narendramodi")),
                    icon: SvgPicture.asset(
                      "assets/twitter.svg",
                      color: Colors.black,
                      width: 35.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 35.0,
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Poppins(
            text: "Dashboard",
            size: 30.0,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await viewModelProvider.reset();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 50.0,
            ),
            //  image+addIncome+total calculations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/login_image.png",
                  width: deviceHeight / 1.6,
                ),
                //todo: add income and expense
                SizedBox(
                  height: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //add expense
                      SizedBox(
                        height: 45.0,
                        width: 160.0,
                        child: MaterialButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              OpenSans(
                                text: "Add expense",
                                size: 17.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await viewModelProvider.addExpense(context);
                          },
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      //add income
                      SizedBox(
                        height: 45.0,
                        width: 160.0,
                        child: MaterialButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              OpenSans(
                                text: "Add income",
                                size: 17.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await viewModelProvider.addIncome(context);
                          },
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  height: 300.0,
                  width: 280.0,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Poppins(
                            text: "Budget Left",
                            size: 17.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: "Total Expense",
                            size: 17.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: "Total Income",
                            size: 17.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Divider(
                          indent: 40.0,
                          endIndent: 40.0,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Poppins(
                            text: budgetLeft.toString(),
                            size: 17.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: totalExpense.toString(),
                            size: 17.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: totalIncome.toString(),
                            size: 17.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Divider(
              indent: deviceWidth / 4,
              endIndent: deviceWidth / 4,
              thickness: 3.0,
            ),
            SizedBox(
              height: 50.0,
            ),
            //expenses + incomes list
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //expenses
                Container(
                  height: 320.0,
                  width: 260.0,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    children: [
                      //expenses heading
                      Center(
                        child: Poppins(
                          text: "Expenses",
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      Divider(
                        indent: 30.0,
                        endIndent: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 210.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          border: Border.all(width: 1.0, color: Colors.white),
                        ),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Poppins(
                                  text: viewModelProvider.expensesName[index],
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Poppins(
                                    text:
                                        viewModelProvider.expensesAmount[index],
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: viewModelProvider.expensesAmount.length,
                        ),
                      ),
                    ],
                  ),
                ),
                //incomes
                Container(
                  height: 320.0,
                  width: 260.0,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    children: [
                      //expenses heading
                      Center(
                        child: Poppins(
                          text: "Incomes",
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      Divider(
                        indent: 30.0,
                        endIndent: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 210.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          border: Border.all(width: 1.0, color: Colors.white),
                        ),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Poppins(
                                  text: viewModelProvider.incomesName[index],
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Poppins(
                                    text:
                                        viewModelProvider.incomesAmount[index],
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: viewModelProvider.incomesAmount.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
