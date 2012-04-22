import cc.arduino.*;
import org.json.*;
import processing.serial.*;

JSONArray json;
JSONArray trending;
String trendingURI;
Arduino arduino;
ArrayList topics; 
int timeBetweenRequests;

void generateTrendsList ()
{
  topics.add("spooner");
  topics.add("jon spooner");
  topics.add("john spooner");
  topics.add("unsa");
  topics.add("unlimited space agency");
  topics.add("spaceapps");
}

void setup()
{
  timeBetweenRequests = 36000;
  // GLOBAL trending topics
//  trendingURI = "https://api.twitter.com/1/trends/1.json";

  // UK trending topics
  trendingURI = "https://api.twitter.com/1/trends/23424975.json";
  
  // Applying Background Colour first means that it is that colour right from the start
  background(199, 193, 172);
  size(800,120);
  
  topics = new ArrayList ();
  
  generateTrendsList ();
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(13, Arduino.OUTPUT); 
}

void ACTIVATE ()
{
  println("WE'RE TRENDING!!!");
  
  //arduino stuff
  background(0,255,0);
  arduino.digitalWrite(13, Arduino.HIGH);
}

void DEACTIVATE ()
{
  background(255,0,0);
  arduino.digitalWrite(13, Arduino.LOW);
}

void draw() 
{  
  DEACTIVATE();

  String[] lines = loadStrings(trendingURI);

  try
  {
    JSONArray trendsarr = new JSONArray(join(lines, ""));
    JSONArray trends = trendsarr.getJSONObject(0).getJSONArray("trends");

    for (int i = 0; i < trends.length(); i++)
    {
      String trend = trends.getJSONObject(i).getString("name").toLowerCase().replace("#", "");
      if (topics.contains(trend))
      {
        ACTIVATE();
      }
    }
  }
  catch (Exception e)
  {
    println("Corrupt json feed");
  }
  
  // don't want to reach the API limit
  // this limits it to 1 request every 36 seconds - or 100 requests/hour
  delay(timeBetweenRequests);
}
