public class ProcessHour {
    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        HourData hd = new HourData();
        hd.genHourData();
        hd.close();
        long stopTime = System.currentTimeMillis();
        System.out.println("Finished in " + (float) (stopTime - startTime) / 1000 + "Seconds");
    }
}