
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/provider/user_provider.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<UserProvider>().clearFilter());
    Future.microtask(() => context.read<UserProvider>().filterTransactions(''));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body:Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:280.w ,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        context.read<UserProvider>().filterTransactions(value);
                      },
                      decoration: InputDecoration(
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.w),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.w),  borderSide: const BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.w),  borderSide: const BorderSide(color: Colors.black, width: 2)),
                        fillColor: Colors.grey,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (context)=>FilterPopUp());
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        color: Colors.purpleAccent,
                        boxShadow:[BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        )] ,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.purpleAccent,
                            Colors.purple,
                          ])
                                  
                      ),
                      child: Icon(Icons.filter_list_alt,color: Colors.white,size: 30.w,),
                    ),
                  )
                ],
              ),
              Expanded(child: Consumer<UserProvider>(builder: (context,userProvider,child){
                if(userProvider.isLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(userProvider.getFilteredTransactions.isEmpty){
                  print(userProvider.getTransactions);
                  return const Center(child: Text('No Transactions'));
                }else{
                   return ListView.builder(
                  itemCount: userProvider.getFilteredTransactions.length,
                  itemBuilder: ((context, index) => ListTile(
                    title: Text(userProvider.getFilteredTransactions[index].type),
                    subtitle: Text(userProvider.getFilteredTransactions[index].description),
                    trailing: Text(userProvider.getFilteredTransactions[index].amount.toString()),
                  ))
                );
                }
                
              }))
            ],
          ),
        ),
      ),
      
    );
  }

  Widget FilterPopUp(){
    return AlertDialog(
      title: const Text('Filter'),
      content:Column(
          children: [
            // Add your filter options here
            ListTile(
              title: const Text('Type'),
              onTap: () => _showTypeFilter(context),
            ),
            ListTile(
              title: const Text('Date'),
              onTap: () => _showDateFilter(context),
            ),
            ListTile(
              title: const Text('Category'),
              onTap: () => _showCategoryFilter(context),
            ),
            ListTile(
              title: const Text('Confirm'),
              onTap: () {
                context.read<UserProvider>().filterTransactions(searchController.text);
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ) ,
    );
  }


void _showTypeFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                title: const Text('All'),
                onTap: () {
                 context.read<UserProvider>().setSelectedType('All');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Income'),
                onTap: () {
                  context.read<UserProvider>().setSelectedType('Income');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Expense'),
                onTap: () {
                  context.read<UserProvider>().setSelectedType('Expense');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to show the date filter
  void _showDateFilter(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate != null) {
        context.read<UserProvider>().setSelectedDate(pickedDate.toString());
      }
    });
  }

  // Helper method to show the category filter
  void _showCategoryFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                title: const Text('All'),
                onTap: () {
                  context.read<UserProvider>().setSelectedCategory('All');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Category 1'),
                onTap: () {
                  context.read<UserProvider>().setSelectedCategory('Category 1');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Category 2'),
                onTap: () {
                  context.read<UserProvider>().setSelectedCategory('Category 2');
                  Navigator.pop(context);
                },
                
              ),
            ],
          ),
        );
      },
    );
  }





}


