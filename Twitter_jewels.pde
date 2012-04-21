


/*
  20110927_twitterapp1
  https://dev.tommetcalfe.com
  @dev_tommetcalfe

  Everytime a tweet is received,
  An LED on the Arduino comes on.
*/

import cc.arduino.*;


Twitter myTwitter;
Arduino arduino;
//FullScreen fs;

/*====================================================================================*/

void setup()
{
  
  // Applying Background Colour first means that it is that colour right from the start
  background(199, 193, 172);
  size(800,120);
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  arduino.pinMode(13, Arduino.OUTPUT);

/*  Annoying code relating to FullScreen

  // 5 fps
  frameRate(5);

  // Create the fullscreen object
  fs = new FullScreen(this); 
  
  // enter fullscreen mode
  fs.enter(); 
*/
}

/*====================================================================================*/

void draw() 
{ 
  
  // how long each tweet is visible for
  delay(500);

  arduino.digitalWrite(13, Arduino.LOW);
  delay(3000);
  
  PFont font2;
    font2 = loadFont("Helvetica-48.vlw");
    fill(0, 102, 153);
 
 // Applying NEW background stops each line printing on top of one another
 background(199, 193, 172);
 
  //text properties
    textAlign(CENTER);
    textFont(font2, 12);
    text("", 12, 24);
    fill(62, 65, 50);
  
  //twitter account name and password
  myTwitter = new Twitter("dev_tommetcalfe", "findplaymaketalk1234");
  try 
  {
    
    //Twitter Search
//    Query query1 = new Query("#spaceapps");
//    query1.setRpp(1);
//    QueryResult result1 = myTwitter.search(query1);
      Trends trends = new Trends ();
      println(trends);
 
//    ArrayList tweets1 = (ArrayList) result1.getTweets();
      for (int i = 0; i < tweets1.size(); i++) 
      {
//      Tweet t = (Tweet) tweets1.get(i);
      
      //Show name of person who placed tweet @.....
      //String user = t.getFromUser();
//      String msg = t.getText();
//      Date d = t.getCreatedAt();
     // text(user, width/2, 1*height/4);
//      text(msg, width/2, height/2);     
    }
 

    //PLACE ARDUINO CODE HERE - need if statement here
    arduino.digitalWrite(13, Arduino.HIGH);
  }
  
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
    }
}
