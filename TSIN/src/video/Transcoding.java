package video;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
public class Transcoding {
    
    private static String inputPath = "";    
    private static String outputPath = "";    
    private static String ffmpegPath = "";
    
    public static void main(String[] args)
    {
    	transcode("C:\\Users\\ibm\\Desktop\\test.mp4","C:\\Users\\ibm\\Desktop\\","out");
    }
    
    public static void transcode(String inPath, String outPath, String name)
    {
    	getPath(inPath, outPath, name);

        if (!checkfile(inputPath)) {
            System.out.println(inputPath + " is not file");
            return;
        }
        if (process()) {
            System.out.println("ok");
        }
    }
    
    private static void getPath(String inPath, String outPath, String name) { // 先获取当前项目路径，在获得源文件、目标文件、转换器的路径
        File diretory = new File("");
        try {
            String currPath = diretory.getAbsolutePath();
            inputPath = inPath;
            if (outputPath.endsWith(File.separator)) {
            	outputPath = outPath + name + ".flv";
            }
            else {
            	outputPath = outPath + File.separator + name + ".flv";
            }
            ffmpegPath = currPath + File.separator + "bin" + File.separator + "ffmpeg";
            System.out.println(currPath);
        }
        catch (Exception e) {
            System.out.println("getPath出错");
        }
    }
    
    private static boolean process() {
        int type = checkContentType();
        boolean status = false;
        if (type == 0) {
            status = processFLV();// 直接转成flv格式
        } else if (type == 1) {
            return false;// 上传格式错误
            }
        return status;
    }

    private static int checkContentType() {
        String type = inputPath.substring(inputPath.lastIndexOf(".") + 1, inputPath.length())
                .toLowerCase();
        // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
        if (type.equals("avi")) {
            return 0;
        } else if (type.equals("mpg")) {
            return 0;
        } else if (type.equals("wmv")) {
            return 0;
        } else if (type.equals("3gp")) {
            return 0;
        } else if (type.equals("mov")) {
            return 0;
        } else if (type.equals("mp4")) {
            return 0;
        } else if (type.equals("asf")) {
            return 0;
        } else if (type.equals("asx")) {
            return 0;
        } else if (type.equals("flv")) {
            return 0;
        }
        // 对ffmpeg无法解析的文件格式(如wmv9，rm，rmvb等)，不允许上传
        return 1;
    }

    private static boolean checkfile(String path) {
        File file = new File(path);
        if (!file.isFile()) {
            return false;
        }
        return true;
    }

    // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
    private static boolean processFLV() {
        if (!checkfile(inputPath)) {
            System.out.println(inputPath + " is not file");
            return false;
        }
        
        List<String> command = new ArrayList<String>();
        command.add(ffmpegPath);
        command.add("-i");
        command.add(inputPath);
        command.add("-ab");
        command.add("128");
        command.add("-ar");
        command.add("44100");
        command.add("-qscale");
        command.add("8");
        command.add("-r");
        command.add("15");
        command.add("-s");
        command.add("1280x720");
        command.add(outputPath);

        try {
            Process videoProcess = new ProcessBuilder(command).redirectErrorStream(true).start();           
            new PrintStream(videoProcess.getErrorStream()).start();
            //new PrintStream(videoProcess.getInputStream()).start();
            videoProcess.waitFor();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

class PrintStream extends Thread 
{
    java.io.InputStream __is = null;
    
    public PrintStream(java.io.InputStream is) 
    {
        __is = is;
    } 

    public void run() 
    {
        try 
        {
            while(this != null) 
            {
                int _ch = __is.read();
                if(_ch != -1) 
                    System.out.print((char)_ch); 
                else break;
            }
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        } 
    }
}