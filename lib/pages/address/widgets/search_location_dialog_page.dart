
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20/2)
        ),
      child: SizedBox(
        width: Dimensions.screenWidth,
        child:
         TypeAheadField(
          textFieldConfiguration:TextFieldConfiguration(
            controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: "konum ara",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  style: BorderStyle.none,width: 0)
              ),
              hintStyle:  Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.fontSize15),
            ),
          ) ,
          suggestionsCallback: (pattern) async{ 
            return await Get.find<LocationController>().searchLocation(context, pattern);
           }, 
          itemBuilder: (BuildContext context, Prediction suggestion) {
            return Padding(
              padding:  EdgeInsets.all(Dimensions.width10),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  Expanded(
                    child: 
                      Text(suggestion.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: Dimensions.fontSize15),
                      )
                  )
                ],
              ),
            );
          }, 
          onSuggestionSelected: (Prediction suggestion)  {  
            Get.find<LocationController>().setLocation(suggestion.placeId!,suggestion.description!,mapController);
            Get.back();
          },
        ),
      ) ,
      ),
    );
  }
}