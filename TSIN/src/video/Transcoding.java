package video;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import common.Path;

public class Transcoding {
    
    private String inputPath = "";    
    private String outputPath = "";    
    private String ffmpegPath = "";
    private String coverPath ="";
    
    /** 外部调用，用于转码的函数 */
    public boolean transcode(String inputName, String outputName, boolean hasCover) {
    	getPath(Path.ORIGINFILEPATH + inputName, Path.TRANSFILEPATH, Path.COVERPATH, outputName);

        if (!checkfile(inputPath)) {
            System.out.println(inputPath + " is not file");
            return false;
        }
        if (!process(hasCover)) {
            return false;
        }
        System.out.println("transcode done");
        return true;
    }
    
    /** 获取使用到的路径 */
    private void getPath(String inPath, String outPath, String cPath,String name) { 
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
            if (coverPath.endsWith(File.separator)) {
            	coverPath = cPath + name + ".jpg";
            }
            else {
            	coverPath = cPath + File.separator + name + ".jpg";
            }
            // ffmpegPath = currPath + File.separator + "bin" + File.separator + "ffmpeg";
            ffmpegPath = Path.FFMPEGPATH;
        }
        catch (Exception e) {
            System.out.println("getPath出错");
        }
    }
    
    /** 进入转码进程*/
    private boolean process(boolean hasCover) {
        int type = checkContentType();
        boolean status = false;
        if (type == 0) {
            status = processFLV();// 直接转成flv格式
            if (!status) {
            	return false;
            }
        } else if (type == 1) {
            return false;// 上传格式错误
        }
        if (!hasCover) {
        	status = processCover();// 视频截图
        } 
        return status;
    }
    
    /** 检查文件是否为可以转码的格式*/
    private int checkContentType() {
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
    private boolean checkfile(String path) {
        File file = new File(path);
        if (!file.isFile()) {
            return false;
        }
        return true;
    }

    /** 转换为flv，ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）*/
    private boolean processFLV() {
        if (!checkfile(inputPath)) {
            System.out.println(inputPath + " is not file");
            return false;
        }
        
        List<String> command = new ArrayList<String>();
        command.add(ffmpegPath);
        // 若存在较旧的则覆盖
        command.add("-y");
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
    
    /** 取视频第一帧为截图 */
    private boolean processCover() {
        
        List<String> command = new ArrayList<String>();
        command.add(ffmpegPath);
        command.add("-y");
        command.add("-i");
        command.add(outputPath);
        command.add("-vframes");
        command.add("1");
        command.add("-r");
        command.add("1");
        command.add("-ac");
        command.add("1");
        command.add("-ab");
        command.add("2");
        command.add("-s");
        command.add("160*120");
        command.add("-f");
        command.add("image2");
        command.add(coverPath);

        try {
            Process coverProcess = new ProcessBuilder(command).redirectErrorStream(true).start();           
            coverProcess.waitFor();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}