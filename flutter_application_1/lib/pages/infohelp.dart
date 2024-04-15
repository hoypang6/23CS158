import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/levelselectionpage.dart';

class InfoHelp extends StatelessWidget{


  InfoHelp({super.key});
  
  @override
  Widget build(BuildContext context) {
return Scaffold( 
      appBar: AppBar(
        title: Text('About the Game'), 
        centerTitle: true,
        leading: BackButton(
            onPressed: (){
            //go back to PCS
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=> LevelSelectionPage(),
                )
            );
          },
        ),
      ),
      body: Center(
        child: Container(

        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Your goal is to place towers to stop the enemies from advancing.'),
            const SizedBox(height:10),
            const Text('Place towers by tapping on one of the icons on the left of the screen, and drag towards the play area.'),
            const SizedBox(height:10),
            const Text('Remember to not place towers the paths or outside the play area!'),
            const SizedBox(height:10),
            const Text('Towers cost points, however it is only deducted when you clear the level (Unless you are playing infinite mode)'),
            const SizedBox(height:10),
            const Text('Towers:'),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/boforsloaded.png',height: 40,width: 6,),
                const SizedBox(width:5),
                Text("500 Points"),
                const SizedBox(width:5),
                Text("Range 1/4"),
                const SizedBox(width:5),
                Text("Damage 1/4"),
                ]
              ),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/qffh.png',height: 40,width: 22,),
                const SizedBox(width:5),
                Text("1000 Points"),
                const SizedBox(width:5),
                Text("Range 2/4"),
                const SizedBox(width:5),
                Text("Damage 2/4"),
                ]
              ),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/auto.png',height: 40,width: 22,),
                const SizedBox(width:5),
                Text("1500 Points"),
                const SizedBox(width:5),
                Text("Range 3/4"),
                const SizedBox(width:5),
                Text("Damage 3/4"),
                ]
              ),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/boforsmod.png',height: 40,width: 19,),
                const SizedBox(width:5),
                Text("2000 Points"),
                const SizedBox(width:5),
                Text("Range 4/4"),
                const SizedBox(width:5),
                Text("Damage 4/4"),
                ]
              ),
            const SizedBox(height:10),
            const Text('Enemies:'),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/toaster.png',height: 40,width: 40,),
                const SizedBox(width:5),
                Text("Toaster"),
                const SizedBox(width:5),
                Text("Speed 1/3"),
                const SizedBox(width:5),
                Text("Health 1/3"),
                ]
              ),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/microwave.png',height: 40,width: 40,),
                const SizedBox(width:5),
                Text("Microwave"),
                const SizedBox(width:5),
                Text("Speed 2/3"),
                const SizedBox(width:5),
                Text("Health 3/3"),
                ]
              ),
            const SizedBox(height:10),
            Row(
              crossAxisAlignment : CrossAxisAlignment.start,
              children : [
                Image.asset('assets/images/vacuum.png',height: 40,width: 40,),
                const SizedBox(width:5),
                Text("Vacuum"),
                const SizedBox(width:5),
                Text("Speed 3/3"),
                const SizedBox(width:5),
                Text("Health 2/3"),
                ]
              ),


           
          ],

        ),
        )

      )
    );
  }
}
  



    