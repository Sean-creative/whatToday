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
 * �ۼ��� : ���μ�, DB�� ���� ���ؼ� �ʿ���� ���� ����
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
	
	
	//������ �������� ����2�ø��� DB�� ���ؼ� DB�� ���� ���������� ������ ������
	@Scheduled(cron="0 0 2 * * *")
	public void checkFiles() throws Exception{
		log.warn("File Check Task run . . . . . .");
		log.warn(new Date());
		//file list in database
		List<UserVO> fileList = attachMapper.getOldFiles();
		
		//ready for check file in directory with database file list
		//���� ��ǻ�� ��η� �ٲ���ҵ� ���� ��δ� �������Դϴ�.
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
