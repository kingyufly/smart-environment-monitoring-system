public class ProcessDay {
    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        DayData dd = new DayData();
        dd.genDayData();
        dd.close();
        long stopTime = System.currentTimeMillis();
        System.out.println("Finished in " + (float) (stopTime - startTime) / 1000 + "Seconds");
	}
}