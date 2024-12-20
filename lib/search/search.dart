import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPageEssai extends StatefulWidget {
  const SearchPageEssai({super.key});

  @override
  State<SearchPageEssai> createState() => _SearchPageEssaiState();
}

class _SearchPageEssaiState extends State<SearchPageEssai> {
  final TextEditingController controller = TextEditingController();
  final List<String> items = [
    "apple",
    "banana",
    "cherry",
    "date",
    "elderberry",
    "fig",
    "grape",
    "honeydew",
    "kiwi",
    "lemon",
    "mango",
    "nectarine",
    "orange",
    "papaya",
    "quince",
    "raspberry",
    "strawberry",
    "tangerine",
    "watermelon",
  ];
  List<String> filteredItem = [];
  bool isExpanded = false;
  bool isSearchBarExpanded = false;

  void onChange(String value) {
    setState(() {
      if (isSearchBarExpanded == true) {
        if (value.isEmpty) {
          isExpanded = false;
          filteredItem = [];
        } else {
          filteredItem = items.where((item) {
            return item.toLowerCase().contains(value.toLowerCase());
          }).toList();
          if (filteredItem.isEmpty) {
            isExpanded = false;
          } else {
            isExpanded = true;
          }
        }
        if (kDebugMode) {
          print("$isExpanded + $filteredItem");
        }
      }
    });
  }

  void toggleSearchBar() {
    setState(() {
      isSearchBarExpanded = !isSearchBarExpanded;
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFF),
      body: !isSearchBarExpanded
          ? Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  isSearchBarExpanded =! isSearchBarExpanded;
                  if (kDebugMode) {
                    print(isSearchBarExpanded);
                  }
                });

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 5),
                        blurRadius: 10
                      )
                    ]

                ),
                  height: 80,
                  width: 80,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
            ),
          )
          : Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(16),
                  boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.5),
                offset: const Offset(1, 5),
                blurRadius: 10
            )]
              ),
              height: isExpanded
                  ? filteredItem.isEmpty
                      ? 80
                      : filteredItem.length <= 4
                          ? (80 + (60 * filteredItem.length.toDouble()))
                          : 380
                  : 80,
              width: MediaQuery.of(context).size.height * 0.4
                  ,
              //padding: isExpanded? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero, // Espacement interne
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            isSearchBarExpanded =! isSearchBarExpanded;
                            if (kDebugMode) {
                              print(isSearchBarExpanded);
                            }
                          });

                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            autofocus: true,
                            onChanged: onChange,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontFamily: 'montserrat'),
                              border: InputBorder.none,
                              //contentPadding: EdgeInsets.all(15)
                              //isDense: true, // Réduit la hauteur totale du champ
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(FontAwesomeIcons.trashCan,
                                size: 25),
                            onPressed: () {
                              setState(() {
                                controller.clear();
                                onChange('');
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      child: Visibility(
                        visible: isExpanded,
                        child: Divider(
                          indent: 16.0,
                          endIndent: 16.0,
                          color: Colors.black.withOpacity(0.5),
                          thickness: 0.5,
                          height: 0.0,
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isExpanded,
                      child: Flexible(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredItem.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(filteredItem[index]),
                                )),
                      ),
                    ),

                  //SizedBox(height: -10,),
                ],
              ),
            ),
          ),
    );
  }
}
