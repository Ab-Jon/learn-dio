import 'package:flutter/material.dart';
import 'package:learndio/services/network_helper.dart';

import '../keys.dart';

class PhotoGalleryScreen extends StatefulWidget{
  const PhotoGalleryScreen({Key? key}) : super(key: key);

  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen>{

  Future<List<String>>? images;
  Future<List<String>> getImagesFromPixaby() async {
   List<String> pixabyImages = [];
    String url = "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=nature";
    NetworkHelper networkHelper = NetworkHelper();
   Map<String, dynamic> data = await networkHelper.getData();

    for (var entry in data["hits"]){
      pixabyImages.add(entry["largeImageURL"]);
    }
    String image = data["hits"][0]["largeImageURL"];
    pixabyImages.add(image);

    return pixabyImages;

  }
  @override
  void initState(){
    images = getImagesFromPixaby();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Gallery API'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<String>>(
            future: images,
            builder: (context, snapshot){

              switch (snapshot.connectionState){

                case ConnectionState.none:
                  return Center(child: Text("Error"));
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator(),);
                case ConnectionState.done:
                  return GridView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6.0,
                        mainAxisSpacing: 6.0,
                      ),
                      itemBuilder: (context, index){
                        return Image.network(snapshot.data![index], fit: BoxFit.cover,);
                      });
              }

            }
          ),
        ),
      ),
    );
  }
}