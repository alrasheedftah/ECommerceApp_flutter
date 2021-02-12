import 'package:ECommerceTask/constants.dart';
import 'package:ECommerceTask/model/Story.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryViewScreen extends StatefulWidget {
  static final String id="StoryViewScreen";
  @override
  _StoryViewScreen createState() => _StoryViewScreen();
}

class _StoryViewScreen extends State<StoryViewScreen> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story"),
        backgroundColor: Color(0x550000FF),
      ),
      body: buildCustomStoryView(),
    );
  }

buildCustomStoryView() {
  var docId=ModalRoute.of(context).settings.arguments;
  List<StoryModel> _storymodel=[];
  print("docID  "+docId);
  Store _stor=Store();
      return  StreamBuilder<QuerySnapshot>(
        stream: _stor.loadStoryByStream(docId.toString()),
              builder:(context,snapShot)
          { 
     if(snapShot.hasData) {
            _storymodel=[];
    print("builStoryBeforif");
    for(var docs in snapShot.data.docs){
        _storymodel.add(StoryModel(
          sImage: docs.data()[MyStoryImage],
          sName: docs.data()[MyStoryName],
          sCaption: docs.data()[MyStoryCaption],
          svedio: docs.data()[MyStoryVedio],
          sType: docs.data()[MyStoryType],
        ));
    }
        if(_storymodel.length > 0)
        return StoryView(
          storyItems:  _storymodel.map( (StoryModel _story){
        if(_story.sType == 'image')
        return   StoryItem.pageImage(
          url: _story.sImage??"https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          caption: _story.sCaption?? "Hello, from the other side",
          controller: storyController,

        );
        else if(_story.sType == 'text')
        return   StoryItem.text(
          title: _story.sCaption ??"Test If Not Contains",
          backgroundColor: Colors.blue,
        );

        else{
          return StoryItem.pageVideo(
            _story.svedio, 
            controller: storyController);
        }
          }).toList(),
      onStoryShow: (s) {
        print("Showing a story");
      },
      onComplete: () {
        print("Completed a cycle");
        Navigator.pop(context);

      },
      progressPosition: ProgressPosition.top,
      repeat: false,
      controller: storyController,
      onVerticalSwipeComplete: (direction){
        if (direction == Direction.down) {
        Navigator.pop(context);
      }
      },
    );
            else{
         return Center( child: Text("No Story Today ")); 
        }
    //  }
    //  );
            }else{
         return Center( child: Text("No Story Today ")); 
            }
          }
      );
    return StoryView(
      storyItems: [
        StoryItem.text(
          title: "I guess you'd love to see more of our food. That's great.",
          backgroundColor: Colors.blue,
          
        ),
        StoryItem.text(
          title: "Nice!\n\nTap to continue.",
          backgroundColor: Colors.red,
          textStyle: TextStyle(
            fontFamily: 'Dancing',
            fontSize: 40,
          ),
        ),
        StoryItem.pageImage(
          url:
              "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
          caption: "Still sampling",
          controller: storyController,
        ),
        StoryItem.pageImage(
            url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
            caption: "Working with gifs",
            controller: storyController),
        StoryItem.pageImage(
          url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          caption: "Hello, from the other side",
          controller: storyController,
        ),
        StoryItem.pageImage(
          url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          caption: "Hello, from the other side2",
          controller: storyController,
        ),
      ],
      onStoryShow: (s) {
        print("Showing a story");
      },
      onComplete: () {
        print("Completed a cycle");
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
      controller: storyController,
    );
  }
}