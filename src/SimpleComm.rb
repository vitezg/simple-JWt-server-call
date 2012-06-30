require 'java'

import "eu.elevat.TwoIntParamJSignal"
import "eu.webtoolkit.jwt.WApplication"
import "eu.webtoolkit.jwt.WText"

# usual boilerplate
class SimpleComm < WApplication
  def initialize(env)
    super

    # text field to display the screen size
    @screensizetext = WText.new 'Screen size:', getRoot

    # use the java class
    # the signal needs a name, too
    @resizesignal = TwoIntParamJSignal.new self, "myresizesignal"

    # add the listener to the resize signal
    # the block will receive the parameters from the client side
    # javascript
    @resizesignal.add_listener(self) { |x,y|
      @screensizetext.setText 'Screen size: '+x.to_s+' ' + y.to_s
    }

    # push some javascript to the client side
    # I use an anonymous function to avoid namespace pollution
    doJavaScript "(function (){
      var oldWidth = 0, oldHeight = 0;
      var myWidth = 0, myHeight = 0;
		
      // call the size checker regularly
      setInterval(function(){
        if( typeof( window.innerWidth ) == 'number' ) {
	  
	  // Non-IE
          myWidth = window.innerWidth;
	  myHeight = window.innerHeight;
	} else if( document.documentElement && (
          document.documentElement.clientWidth ||document.documentElement.clientHeight ) ) {
	  
	  // IE 6+ in 'standards compliant mode'
          myWidth = document.documentElement.clientWidth;
	  myHeight = document.documentElement.clientHeight;
	} else if( document.body && (document.body.clientWidth ||document.body.clientHeight ) ) {
			
	  // IE 4 compatible
	  myWidth = document.body.clientWidth;
	  myHeight = document.body.clientHeight;
	}
	if ((oldWidth!=myWidth) || (oldHeight!=myHeight) ){
          oldWidth=myWidth;
          oldHeight=myHeight;
	
	  // insert the call for the resize signal here
	  // the parameters are the new width and height
	  // this way the myWidth and myHeight variables get transmitted
	  // to the ruby block as x and y
	  "+@resizesignal.createCall("myWidth","myHeight")+";
	 }
       },50);
     })();"

  end

end
