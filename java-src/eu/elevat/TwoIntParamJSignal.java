package eu.elevat;

// JSignal with two parameters
import eu.webtoolkit.jwt.JSignal2;
import eu.webtoolkit.jwt.WObject;

// really a very simple class
// the two integers will be the window width and height
class TwoIntParamJSignal extends JSignal2<Integer, Integer>
{
  public TwoIntParamJSignal (WObject wobject, String string)
  { 
    super(wobject, string);
  }
                 
}
