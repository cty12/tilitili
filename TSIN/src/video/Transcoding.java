package video;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import common.Path;

public class Transcoding {
    
    private static String inputPath = "";    
    private static String outputPath = "";    
    private static String ffmpegPath = "";
    
    public static void main(String[] args) {
    	transcode("test.mp4", "1");
    }
    
    /** 外部调用，用于转码的函数 */
    public static boolean transcode(String inputName, String outputName) {
    	getPath(Path.ORIGINFILEPATH + inputName, Path.TRANSFILEPATH, outputName);

        if (!checkfile(inputPath)) {
            System.out.println(inputPath + " is not file");
            return false;
        }
        if (!process()) {
            return false;
        }
        System.out.println("ok");
        return true;
    }
    
    /** 获取使用到的路径 */
    private static void getPath(String inPath, String outPath, String name) { 
    	// 先获取当前项目路径，在获得源文件、目标文件、转换器的路径
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
        }
        catch (Exception e) {
            System.out.println("getPath出错");
        }
    }
    
    /** 进入转码进程*/
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
    
    /** 检查文件是否为可以转码的格式*/
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

    /** 检查是待转码文件是否存在*/
    private static boolean checkfile(String path) {
        File file = new File(path);
        if (!file.isFile()) {
            return false;
        }
        return true;
    }

    /** 转换为flv，ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）*/
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
            videoProcess.waitFor();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}