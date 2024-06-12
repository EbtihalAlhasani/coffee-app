

import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecyclingInfoScreen2 extends StatefulWidget {
  const RecyclingInfoScreen2({super.key});

  @override
  State<RecyclingInfoScreen2> createState() => _RecyclingInfoScreen2State();
}

class _RecyclingInfoScreen2State extends State<RecyclingInfoScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: milkyColor,
      appBar: AppBar(
          backgroundColor: darkBrownColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        title: Text('Recycling Info',style: titleWhite,),
    ),
    body: ListView(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Text(
            "What does Recycling mean?",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: darkBrownColor,
                fontWeight: FontWeight.w700
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text:"Recycling is the process of collecting, processing, and repurposing waste materials into new products. The goal is to reduce landfill waste and conserve natural resources. Here's a simplified breakdown of the recycling process:\n\n",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w400
                  ),
                ),
                TextSpan(
                  text: '1. Collection: ',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(text: 'Gathering recyclable materials from various sources like homes and businesses.\n',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w400
                  ),
                ),
                TextSpan(
                  text: '2. Sorting: ',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(text: 'Separating collected materials into categories like paper, plastics, metals, and glass.\n',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w400
                  ),
                ),
                TextSpan(
                  text: '3. Processing: ',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(text: "Cleaning and converting sorted materials into raw forms for manufacturing.\n",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w400
                  ),
                ),
                TextSpan(
                  text: '4. Manufacturing: ',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(text: "Using processed materials to create new products.\n",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w400
                  ),
                ),
                TextSpan(
                  text: '5. Purchasing Recycled Products: ',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(text: "Consumers buying products made from recycled materials, supporting the recycling cycle.",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: darkBrownColor,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Text(
            "Benefits of Recycling",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: darkBrownColor,
                fontWeight: FontWeight.w700
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "•	Conserves Resources: Saves natural resources like timber, water, and minerals.\n•	Saves Energy: Requires less energy than producing new products from raw materials.\n•	Reduces Pollution: Lowers pollution from raw material extraction and processing.\n•	Decreases Emissions: Reduces greenhouse gas emissions by lowering energy use.\n•	Reduces Waste: Keeps waste out of landfills and incinerators.\n\nRecycling is essential for sustainable waste management and environmental conservation, promoting efficient resource use and reducing the ecological footprint.",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
                color: darkBrownColor,
                fontWeight: FontWeight.w400
            ),
          ),
        ),

        SizedBox(height: 20,),

        Image.asset("assets/images/recycling_img1.jpeg"),

        SizedBox(height: 20,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Text(
            "Recycling Coffee Waste",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: darkBrownColor,
                fontWeight: FontWeight.w700
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Recycling coffee waste offers significant environmental benefits, helping mitigate waste and promote sustainability:\n",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15,
                color: darkBrownColor,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Reduction in Landfill Waste:",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                "- Less Waste: Diverts large amounts of organic material from landfills.\n- Methane Reduction: Reduces methane production from anaerobic decomposition.\n",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w400
                ),
              ),

              Text(
                " 2. Decreased Greenhouse Gas Emissions:",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                "- Lower Emissions: Creates biofuel or compost, reducing the need for fossil fuels and synthetic fertilizers.\n- Carbon Sequestration: Helps sequester carbon in the soil when used as compost or soil amendment.\n",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w400
                ),
              ),


              Text(
                " 3. Resource Conservation:",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                "- Natural Fertilizer: Reduces the need for chemical fertilizers, minimizing soil and water pollution.- Renewable Energy: Converts waste into biofuel, conserving fossil fuel resources.\n",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w400
                ),
              ),

              Text(
                " 4. Enhanced Soil Health:",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                "- Nutrient-Rich Compost: Adds essential nutrients like nitrogen, potassium, and phosphorus to the soil.\n- Soil Structure Improvement: Improves soil structure, water retention, and supports beneficial microbial activity.\nIn summary, recycling coffee waste reduces landfill waste and greenhouse gas emissions, conserves resources, enhances soil health, and supports overall environmental sustainability. These benefits contribute to a healthier planet and a more sustainable future.\n",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: darkBrownColor,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),



        Image.asset("assets/images/recycling_img2.jpeg"),
      ],
    ),);
  }
}
