package kr.co.winthemovie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/movie")
public class AnalysisController {
	
	@RequestMapping(value="/analysis", method=RequestMethod.GET)
	public String analysisform() {
		return "movie/analysis";
	}
}