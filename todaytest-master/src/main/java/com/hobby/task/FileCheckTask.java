package com.hobby.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hobby.domain.UserVO;
import com.hobby.mapper.MypageMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * 작성자 : 국민성, DB와 파일 비교해서 필요없는 파일 삭제
 */

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private MypageMapper attachMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	
	//서버가 켜있으면 새벽2시마다 DB와 비교해서 DB에 없는 유저프로필 사진은 삭제함
	@Scheduled(cron="0 0 2 * * *")
	public void checkFiles() throws Exception{
		log.warn("File Check Task run . . . . . .");
		log.warn(new Date());
		//file list in database
		List<UserVO> fileList = attachMapper.getOldFiles();
		
		//ready for check file in directory with database file list
		//각자 컴퓨터 경로로 바꿔야할듯 현재 경로는 프로필입니다.
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("C:\\Users\\sudal\\Desktop\\workspace\\todaytest-master\\src\\main\\webapp\\resources\\img\\upload"
						, vo.getUsrImgPath(),vo.getUsrImg())).collect(Collectors.toList());
		
		log.warn("========================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		File targetDir = Paths.get("C:\\Users\\sudal\\Desktop\\workspace\\todaytest-master\\src\\main\\webapp\\resources\\img\\upload"
				, getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("-----------------------------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
