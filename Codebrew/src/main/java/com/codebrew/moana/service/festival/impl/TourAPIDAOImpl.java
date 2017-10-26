package com.codebrew.moana.service.festival.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Weather;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalDAO;

@Repository("tourAPIDAOImpl")
public class TourAPIDAOImpl implements FestivalDAO {

	/// Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	@Value("#{keyProperties['tourKey']}")
	String tourKey;

	@Value("#{keyProperties['tourURL']}")
	String tourURL;

	@Value("#{keyProperties['detailCommonBasicForm']}")
	String detailCommonBasicForm;

	@Value("#{keyProperties['detailIntroBasicForm']}")
	String detailIntroBasicForm;

	@Value("#{keyProperties['searchFestivalBasicForm']}")
	String searchFestivalBasicForm;

	@Value("#{keyProperties['searchKeywordBasicForm']}")
	String searchKeywordBasicForm;

	@Value("#{keyProperties['weatherURL']}")
	String weatherURL;

	@Value("#{keyProperties['forecastSpaceDataBasicForm']}")
	String forecastSpaceDataBasicForm;

	private Festival festival;
	
	private Weather weather;

	Date dt = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	int currentDate = Integer.parseInt(sdf.format(dt).toString());

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/// Constructor
	public TourAPIDAOImpl() {
		System.out.println(this.getClass());
	}

	public static final StringBuilder sendGetURL(StringBuilder urlBuilder) throws Exception {

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}

		rd.close();
		conn.disconnect();

		return sb;

	}

	public Festival getFestival(int festivalNo) throws Exception {

		StringBuilder urlBuilder = new StringBuilder(tourURL + detailCommonBasicForm + festivalNo);

		StringBuilder sb = TourAPIDAOImpl.sendGetURL(urlBuilder);

		JSONObject jsonobj = (JSONObject) JSONValue.parse(sb.toString());
		JSONObject jsonobj2 = (JSONObject) jsonobj.get("response");
		JSONObject jsonobj3 = (JSONObject) jsonobj2.get("body");
		JSONObject jsonobj4 = (JSONObject) jsonobj3.get("items");
		JSONObject jsonobj5 = (JSONObject) jsonobj4.get("item");

		Festival festival = new Festival();

		if (jsonobj5.get("homepage") == null || jsonobj5.get("homepage") == "") {
			festival.setHomepage("제공정보없음");
		} else {
			festival.setHomepage(jsonobj5.get("homepage").toString());
		}

		if (jsonobj5.get("overview") == null || jsonobj5.get("overview") == "") {
			festival.setFestivalOverview("제공정보없음");
		} else {
			festival.setFestivalOverview(jsonobj5.get("overview").toString());
		}

		if (jsonobj5.get("addr1") == null || jsonobj5.get("addr1") == "") {
			festival.setAddr("제공정보없음");
		} else {
			festival.setAddr(jsonobj5.get("addr1").toString()); // 주소
		}

		if (jsonobj5.get("contentid") == null || jsonobj5.get("contentid") == "") {
			festival.setFestivalNo(Integer.parseInt("제공정보없음"));
		} else {
			festival.setFestivalNo(Integer.parseInt(jsonobj5.get("contentid").toString())); // 축제아이디
		}

		if (jsonobj5.get("firstimage") == null || jsonobj5.get("firstimage") == "") {
			festival.setFestivalImage("제공정보없음");
		} else {
			festival.setFestivalImage(jsonobj5.get("firstimage").toString()); // 원본사진
		}

		if (jsonobj5.get("title") == null || jsonobj5.get("title") == "") {
			festival.setFestivalName("제공정보없음");
		} else {
			festival.setFestivalName(jsonobj5.get("title").toString()); // 제목
		}

		if (jsonobj5.get("areacode") == null || jsonobj5.get("areacode") == "") {
			festival.setAreaCode("제공정보없음");
		} else {
			festival.setAreaCode(jsonobj5.get("areacode").toString()); // 지역번호
		}

		if (jsonobj5.get("mapy") == null || jsonobj5.get("mapy") == "") {
			festival.setFestivalLatitude("제공정보없음");
		} else {
			festival.setFestivalLatitude(jsonobj5.get("mapy").toString()); // 위도
		}

		if (jsonobj5.get("mapx") == null || jsonobj5.get("mapx") == "") {
			festival.setFestivalLongitude("제공정보없음");
		} else {
			festival.setFestivalLongitude(jsonobj5.get("mapx").toString()); // 경도
		}

		if (jsonobj5.get("contenttypeid") == null || jsonobj5.get("contenttypeid") == "") {
			festival.setContentTypeId("제공정보없음");
		} else {
			festival.setContentTypeId(jsonobj5.get("contenttypeid").toString()); // 축제
		}

		if (jsonobj5.get("tel") == null || jsonobj5.get("tel") == "") {
			festival.setOrgPhone("제공정보없음");
		} else {
			festival.setOrgPhone(jsonobj5.get("tel").toString()); // 전화번호
		}

		if (jsonobj5.get("sigungucode") == null || jsonobj5.get("sigungucode") == "") {
			festival.setSigunguCode("제공정보없음");
		} else {
			festival.setSigunguCode(jsonobj5.get("sigungucode").toString()); // 시군구코드
		}

		StringBuilder urlBuilder3 = new StringBuilder(tourURL + detailIntroBasicForm + festivalNo);
		StringBuilder sb3 = TourAPIDAOImpl.sendGetURL(urlBuilder3);

		JSONObject jsonobj11 = (JSONObject) JSONValue.parse(sb3.toString());
		JSONObject jsonobj12 = (JSONObject) jsonobj11.get("response");
		JSONObject jsonobj13 = (JSONObject) jsonobj12.get("body");
		JSONObject jsonobj14 = (JSONObject) jsonobj13.get("items");
		JSONObject jsonobj15 = (JSONObject) jsonobj14.get("item");

		if (jsonobj15.get("eventstartdate") == null || jsonobj15.get("eventstartdate") == "") {
			festival.setStartDate("제공정보없음");
		} else {
			festival.setStartDate(jsonobj15.get("eventstartdate").toString()); // 시작일
		}

		if (jsonobj15.get("eventenddate") == null || jsonobj15.get("eventenddate") == "") {
			festival.setEndDate("제공정보없음");
		} else {
			festival.setEndDate(jsonobj15.get("eventenddate").toString()); // 종료일
		}

		if (jsonobj15.get("agelimit") == null || jsonobj15.get("agelimit") == "") {
			festival.setAgeLimit("제공정보없음");
		} else {
			festival.setAgeLimit(jsonobj15.get("agelimit").toString());// 연령제한
		}

		if (jsonobj15.get("bookingplace") == null || jsonobj15.get("bookingplace") == "") {
			festival.setBookingPlace("제공정보없음");
		} else {
			festival.setBookingPlace(jsonobj15.get("bookingplace").toString()); // 예매처
		}

		if (jsonobj15.get("discountinfofestival") == null || jsonobj15.get("discountinfofestival") == "") {
			festival.setDiscount("제공정보없음");
		} else {
			festival.setDiscount(jsonobj15.get("discountinfofestival").toString());
		}

		if (jsonobj15.get("playtime") == null || jsonobj15.get("playtime") == "") {
			festival.setPlayTime("제공정보없음");
		} else {
			festival.setPlayTime(jsonobj15.get("playtime").toString());
		}

		if (jsonobj15.get("spendtimefestival") == null || jsonobj15.get("spendtimefestival") == "") {
			festival.setSpendTimeFestival("제공정보없음");
		} else {
			festival.setSpendTimeFestival(jsonobj15.get("spendtimefestival").toString());
		}

		if (jsonobj15.get("subevent") == null || jsonobj15.get("subevent") == "") {
			festival.setSubEvent("제공정보없음");
		} else {
			festival.setSubEvent(jsonobj15.get("subevent").toString());
		}

		if (jsonobj15.get("program") == null || jsonobj15.get("program") == "") {
			festival.setProgram("제공정보없음");
		} else {
			festival.setProgram(jsonobj15.get("program").toString());
		}

		if (jsonobj15.get("usetimefestival") == null || jsonobj15.get("usetimefestival") == "") {
			festival.setUseTimeFestival("제공정보없음");
		} else {
			festival.setUseTimeFestival(jsonobj15.get("usetimefestival").toString());
		}

		this.festival = festival;

		return festival;
	}

	public Map<String, Object> getFestivalList(Search search) throws Exception {

		StringBuilder urlBuilder = new StringBuilder(tourURL + searchFestivalBasicForm);
		urlBuilder.append("&areaCode=" + search.getSearchCondition() + "&eventStartDate=" + currentDate + "&arrange="
				+ search.getArrange() + "&pageNo=" + search.getCurrentPage());

		StringBuilder sb = TourAPIDAOImpl.sendGetURL(urlBuilder);

		Map<String, Object> map = new HashMap<String, Object>();

		List<Festival> list = new ArrayList<Festival>();

		JSONObject jsonobj = (JSONObject) JSONValue.parse(sb.toString());
		JSONObject jsonobj2 = (JSONObject) jsonobj.get("response");

		JSONObject jsonobj3 = (JSONObject) jsonobj2.get("body");
		int totalCount = Integer.parseInt(jsonobj3.get("totalCount").toString());
		map.put("totalCount", totalCount);

		JSONObject jsonobj4 = (JSONObject) jsonobj3.get("items");
		JSONArray jsonarray = (JSONArray) jsonobj4.get("item");

		for (int i = 0; i < jsonarray.size(); i++) {

			JSONObject jsonobj5 = (JSONObject) jsonarray.get(i);

			Festival festival = new Festival();

			if (jsonobj5.get("firstimage") == null || jsonobj5.get("firstimage") == "") {
				// festival.setFestivalImage("no.png");
				festival.setFestivalImage(null);
			} else {
				festival.setFestivalImage(jsonobj5.get("firstimage").toString()); // 원본사진
			}

			if (jsonobj5.get("addr1") == null || jsonobj5.get("addr1") == "") {
				festival.setAddr("제공정보없음");
			} else {
				festival.setAddr(jsonobj5.get("addr1").toString()); // 주소
			}

			if (jsonobj5.get("contentid") == null || jsonobj5.get("contentid") == "") {
				festival.setFestivalNo(Integer.parseInt("제공정보없음"));
			} else {
				festival.setFestivalNo(Integer.parseInt(jsonobj5.get("contentid").toString())); // 축제아이디
			}

			if (jsonobj5.get("title") == null || jsonobj5.get("title") == "") {
				festival.setFestivalName("제공정보없음");
			} else {
				festival.setFestivalName(jsonobj5.get("title").toString()); // 제목
			}

			if (jsonobj5.get("areacode") == null || jsonobj5.get("areacode") == "") {
				festival.setAreaCode("제공정보없음");
			} else {
				festival.setAreaCode(jsonobj5.get("areacode").toString());
			}

			if (jsonobj5.get("mapy") == null || jsonobj5.get("mapy") == "") {
				festival.setFestivalLatitude("제공정보없음");
			} else {
				festival.setFestivalLatitude(jsonobj5.get("mapy").toString()); // 위도
			}

			if (jsonobj5.get("mapx") == null || jsonobj5.get("mapx") == "") {
				festival.setFestivalLongitude("제공정보없음");
			} else {
				festival.setFestivalLongitude(jsonobj5.get("mapx").toString()); // 경도
			}

			if (jsonobj5.get("contenttypeid") == null || jsonobj5.get("contenttypeid") == "") {
				festival.setContentTypeId("제공정보없음");
			} else {
				festival.setContentTypeId(jsonobj5.get("contenttypeid").toString()); // 축제
			}

			if (jsonobj5.get("tel") == null || jsonobj5.get("tel") == "") {
				festival.setOrgPhone("제공정보없음");
			} else {
				festival.setOrgPhone(jsonobj5.get("tel").toString()); // 전화번호
			}

			if (jsonobj5.get("eventstartdate") == null || jsonobj5.get("eventstartdate") == "") {
				festival.setStartDate("제공정보없음");
			} else {
				festival.setStartDate(jsonobj5.get("eventstartdate").toString()); // 시작일
			}

			if (jsonobj5.get("eventenddate") == null || jsonobj5.get("eventenddate") == "") {
				festival.setEndDate("제공정보없음");
			} else {
				festival.setEndDate(jsonobj5.get("eventenddate").toString()); // 종료일
			}

			if (jsonobj5.get("sigungucode") == null) {
				festival.setSigunguCode("제공정보없음");
			} else {
				festival.setSigunguCode(jsonobj5.get("sigungucode").toString()); // 시군구코드
			}

			this.festival = festival;

			list.add(festival);

			map.put("list", list); // 추가

		}

		return map;
	}

	@Override
	public Map<String, Object> searchKeywordList(Search search) throws Exception {
		// TODO Auto-generated method stub

		StringBuilder urlBuilder = new StringBuilder(tourURL + searchKeywordBasicForm);

		urlBuilder.append(URLEncoder.encode(search.getSearchKeyword(), "UTF-8"));
		urlBuilder.append("&areaCode=" + search.getSearchCondition() + "&arrange=" + search.getArrange() + "&pageNo="
				+ search.getCurrentPage());

		StringBuilder sb = TourAPIDAOImpl.sendGetURL(urlBuilder);

		Map<String, Object> map = new HashMap<String, Object>();
		List<Festival> list = new ArrayList<Festival>();

		try {
			JSONObject jsonobj = (JSONObject) JSONValue.parse(sb.toString());
			JSONObject jsonobj2 = (JSONObject) jsonobj.get("response");

			JSONObject jsonobj3 = (JSONObject) jsonobj2.get("body");
			int totalCount = Integer.parseInt(jsonobj3.get("totalCount").toString());
			map.put("totalCount", totalCount);

			JSONObject jsonobj4 = (JSONObject) jsonobj3.get("items");
			JSONArray jsonarray = (JSONArray) jsonobj4.get("item");

			for (int i = 0; i < jsonarray.size(); i++) {

				JSONObject jsonobj5 = (JSONObject) jsonarray.get(i);

				Festival festival = new Festival();

				if (jsonobj5.get("content") == null || jsonobj5.get("firstimage") == "") {
					festival.setFestivalImage("../images/uploadFiles/no.png");
				} else {
					festival.setFestivalImage(jsonobj5.get("firstimage").toString()); // 원본사진
				}

				if (jsonobj5.get("firstimage") == null || jsonobj5.get("firstimage") == "") {
					festival.setFestivalImage("../images/uploadFiles/no.png");
				} else {
					festival.setFestivalImage(jsonobj5.get("firstimage").toString()); // 원본사진
				}

				if (jsonobj5.get("addr1") == null || jsonobj5.get("addr1") == "") {
					festival.setAddr("제공정보없음");
				} else {
					festival.setAddr(jsonobj5.get("addr1").toString()); // 주소
				}

				if (jsonobj5.get("contentid") == null || jsonobj5.get("contentid") == "") {
					festival.setFestivalNo(Integer.parseInt("제공정보없음"));
				} else {
					festival.setFestivalNo(Integer.parseInt(jsonobj5.get("contentid").toString())); // 축제아이디
				}

				if (jsonobj5.get("title") == null || jsonobj5.get("title") == "") {
					festival.setFestivalName("제공정보없음");
				} else {
					festival.setFestivalName(jsonobj5.get("title").toString()); // 제목
				}

				if (jsonobj5.get("areacode") == null || jsonobj5.get("areacode") == "") {
					festival.setAreaCode("제공정보없음");
				} else {
					festival.setAreaCode(jsonobj5.get("areacode").toString());
				}

				if (jsonobj5.get("mapy") == null || jsonobj5.get("mapy") == "") {
					festival.setFestivalLatitude("제공정보없음");
				} else {
					festival.setFestivalLatitude(jsonobj5.get("mapy").toString()); // 위도
				}

				if (jsonobj5.get("mapx") == null || jsonobj5.get("mapx") == "") {
					festival.setFestivalLongitude("제공정보없음");
				} else {
					festival.setFestivalLongitude(jsonobj5.get("mapx").toString()); // 경도
				}

				if (jsonobj5.get("contenttypeid") == null || jsonobj5.get("contenttypeid") == "") {
					festival.setContentTypeId("제공정보없음");
				} else {
					festival.setContentTypeId(jsonobj5.get("contenttypeid").toString()); // 축제
				}

				if (jsonobj5.get("tel") == null || jsonobj5.get("tel") == "") {
					festival.setOrgPhone("제공정보없음");
				} else {
					festival.setOrgPhone(jsonobj5.get("tel").toString()); // 전화번호
				}

				if (jsonobj5.get("sigungucode") == null) {
					festival.setSigunguCode("제공정보없음");
				} else {
					festival.setSigunguCode(jsonobj5.get("sigungucode").toString()); // 시군구코드
				}

				StringBuilder urlBuilder2 = new StringBuilder(
						tourURL + detailIntroBasicForm + jsonobj5.get("contentid"));
				StringBuilder sb2 = TourAPIDAOImpl.sendGetURL(urlBuilder2);

				JSONObject jsonobj11 = (JSONObject) JSONValue.parse(sb2.toString());
				JSONObject jsonobj12 = (JSONObject) jsonobj11.get("response");
				JSONObject jsonobj13 = (JSONObject) jsonobj12.get("body");
				JSONObject jsonobj14 = (JSONObject) jsonobj13.get("items");
				JSONObject jsonobj15 = (JSONObject) jsonobj14.get("item");

				if (jsonobj15.get("eventstartdate") == null || jsonobj15.get("eventstartdate") == "") {
					festival.setStartDate("제공정보없음");
				} else {
					festival.setStartDate(jsonobj15.get("eventstartdate").toString()); // 시작일
				}

				if (jsonobj15.get("eventenddate") == null || jsonobj15.get("eventenddate") == "") {
					festival.setEndDate("제공정보없음");
				} else {
					festival.setEndDate(jsonobj15.get("eventenddate").toString()); // 종료일
				}

				this.festival = festival;

				list.add(festival);

				map.put("list", list); // 추가

			}
		} catch (Exception e) {
			// TODO: handle exception
			Festival festival = new Festival();

			festival.setIsNull(true);

			this.festival = festival;

			list.add(festival);

			map.put("list", list);

		}

		return map;
	}

	public Map<String,Object> weather(String festivalLat, String festivalLon) throws Exception {
		
		System.out.println("weatherDAO........" + festivalLon + " / " + festivalLat);

		StringBuilder urlBuilder = new StringBuilder(weatherURL + forecastSpaceDataBasicForm);
		urlBuilder.append(
				"&base_date=" + currentDate + "&nx=" + festivalLon + "&ny=" + festivalLat + "&_type=json");

		StringBuilder sb = TourAPIDAOImpl.sendGetURL(urlBuilder);
		
		Map<String, Object> map = new HashMap<String, Object>();

		List<Weather> list = new ArrayList<Weather>();
		
		

		JSONObject jsonobj = (JSONObject) JSONValue.parse(sb.toString());
		JSONObject jsonobj2 = (JSONObject) jsonobj.get("response");
		JSONObject jsonobj3 = (JSONObject) jsonobj2.get("body");
		JSONObject jsonobj4 = (JSONObject) jsonobj3.get("items");
		JSONArray jsonarray = (JSONArray) jsonobj4.get("item");
		
		System.out.println("jsonobj 확인.........." + jsonarray);

		for (int i = 0; i < jsonarray.size(); i++) {

			JSONObject jsonobj5 = (JSONObject) jsonarray.get(i);
			
			Weather weather = new Weather();
			ObjectMapper objectMapper = new ObjectMapper();
			weather = objectMapper.readValue(jsonobj5.toString(), Weather.class);
			
			System.out.println("DAO에서 weather.........." + weather);
			
			this.weather=weather;
			
			list.add(weather);
			
			map.put("list", list);

		}
		
		
		return map;

	}

	///////////////////////////////////////////////////////////////
	@Override
	public Festival getFestivalDB(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Festival> getFestivalListDB(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public Zzim getZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void appendReadCount(Festival festival) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void addFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void writeFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub

	}

}
