import 'package:flutter/material.dart';
import 'package:search_image/provider/provider.dart';

Widget customTextField(context,
    {required GlobalKey<FormState> formKey, required HomeProvider homeProv}) {
  return Form(
    key: formKey,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
      padding: const EdgeInsets.all(7.5),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 4, offset: Offset(0, 4), color: Colors.white)
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              controller: homeProv.searchController,
              onTap: () {
                // homeProv.toggleAutoFocus(true);
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade800),
                      borderRadius: BorderRadius.circular(5)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(5)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600),
                      borderRadius: BorderRadius.circular(7.5)),
                  hintText: 'Search image',
                  suffixIcon: InkWell(
                    onTap: () {
                      homeProv.searchController.clear();
                      homeProv.fetchImageDatas(showLoading: false);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black54,
                    ),
                  )),
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              autofocus: homeProv.autoFocus,
              onFieldSubmitted: (value) {
                if (formKey.currentState!.validate()) {
                  homeProv.fetchImageDatas(searchQuery: value);
                  print(value);
                }
              },
              // onChanged: homeProv.onChanged,
              // onChanged: homeProv.onChanged,sq
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                homeProv.fetchImageDatas(
                    searchQuery: homeProv.searchController.text);
                FocusScope.of(context).unfocus();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
