import java.io.Serializable;
import java.util.ArrayList;

public class NumberRangeMessage implements Serializable
{
    private int startNumber;
    private int endNumber;
    private ArrayList<String> inputList;

    public NumberRangeMessage(ArrayList<String> inputList, int startNumber, int endNumber) {
        this.startNumber = startNumber;
        this.endNumber = endNumber;
        this.inputList = inputList;
    }

    public int getStartNumber() {
        return startNumber;
    }

    public void setStartNumber(int startNumber) {
        this.startNumber = startNumber;
    }

    public int getEndNumber() {
        return endNumber;
    }

    public void setEndNumber(int endNumber) {
        this.endNumber = endNumber;
    }
    
    public ArrayList<String> getInputList()
    {
    	return inputList;
    }
}