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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalDAO;

@Repository("festivalDAOImpl")
public class FestivalDAOImpl implements FestivalDAO {

	/// Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	private Festival festival;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/// Constructor
	public FestivalDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub

		sqlSession.insert("FestivalMapper.addFestival", festival);
	}

	public Festival getFestival(int festivalNo) throws Exception {

		StringBuilder urlBuilder2 = new StringBuilder(
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon"); /* URL */
		urlBuilder2.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
				+ "=hOlSrH9rpwUcpck4Zl2Wnewju3LzLtgYgAqtW%2FVCRaCJ4BMFUxYFO%2FkzQYu7hbohWd4Z8PWeG9gWgteLzsZqVQ%3D%3D&_type=json"); /*
																																	 */

		urlBuilder2.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + festivalNo);
		urlBuilder2.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=15");
		urlBuilder2.append("&" + URLEncoder.encode("defaultYN", "UTF-8") + "=" + "Y");
		urlBuilder2.append("&" + URLEncoder.encode("firstImageYN", "UTF-8") + "=" + "Y");
		urlBuilder2.append("&" + URLEncoder.encode("areacodeYN", "UTF-8") + "=" + "Y");
		urlBuilder2.append("&" + URLEncoder.encode("addrinfoYN", "UTF-8") + "=" + "Y");
		urlBuilder2.append("&" + URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + "Y");
		urlBuilder2.append("&" + URLEncoder.encode("overviewYN", "UTF-8") + "=" + "Y");
		urlBuilder2.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=ETC");
		urlBuilder2.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=TourAPI3.0_Guide");

		URL url2 = new URL(urlBuilder2.toString());
		HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
		conn2.setRequestMethod("GET");
		conn2.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn2.getResponseCode());
		BufferedReader rd2;
		if (conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
			rd2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
		} else {
			rd2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream(), "UTF-8"));
		}
		StringBuilder sb2 = new StringBuilder();
		String line2;
		while ((line2 = rd2.readLine()) != null) {
			sb2.append(line2);
		}

		rd2.close();
		conn2.disconnect();

		JSONObject jsonobj = (JSONObject) JSONValue.parse(sb2.toString());
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

		StringBuilder urlBuilder3 = new StringBuilder(
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro");
		urlBuilder3.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
				+ "=hOlSrH9rpwUcpck4Zl2Wnewju3LzLtgYgAqtW%2FVCRaCJ4BMFUxYFO%2FkzQYu7hbohWd4Z8PWeG9gWgteLzsZqVQ%3D%3D&_type=json");

		urlBuilder3.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + festivalNo);
		urlBuilder3.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=15");
		urlBuilder3.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=ETC");
		urlBuilder3.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=TourAPI3.0_Guide");

		URL url3 = new URL(urlBuilder3.toString());
		HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();
		conn3.setRequestMethod("GET");
		conn3.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn3.getResponseCode());
		BufferedReader rd3;
		if (conn3.getResponseCode() >= 200 && conn3.getResponseCode() <= 300) {
			rd3 = new BufferedReader(new InputStreamReader(conn3.getInputStream(), "UTF-8"));
		} else {
			rd3 = new BufferedReader(new InputStreamReader(conn3.getErrorStream(), "UTF-8"));
		}
		StringBuilder sb3 = new StringBuilder();
		String line3;
		while ((line3 = rd3.readLine()) != null) {
			sb3.append(line3);
		}
		rd3.close();
		conn3.disconnect();

		JSONObject jsonobj11 = (JSONObject) JSONValue.parse(sb3.toString());

		JSONObject jsonobj12 = (JSONObject) jsonobj11.get("response");

		JSONObject jsonobj13 = (JSONObject) jsonobj12.get("body");

		JSONObject jsonobj14 = (JSONObject) jsonobj13.get("items");

		JSONObject jsonobj15 = (JSONObject) jsonobj14.get("item");

		if (jsonobj5.get("firstimage") != null || jsonobj5.get("firstimage2") != null) {

			System.out.println("json......" + jsonobj15);

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

		}
		return festival;
	}

	public Map<String, Object> getFestivalList(Search search) throws Exception {

		Date dt = new Date();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		int currentDate = Integer.parseInt(sdf.format(dt).toString());

		StringBuilder urlBuilder2 = new StringBuilder(
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival");
		urlBuilder2.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
				+ "=hOlSrH9rpwUcpck4Zl2Wnewju3LzLtgYgAqtW%2FVCRaCJ4BMFUxYFO%2FkzQYu7hbohWd4Z8PWeG9gWgteLzsZqVQ%3D%3D&_type=json");

		urlBuilder2.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=15");
		urlBuilder2.append("&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + search.getSearchCondition());
		urlBuilder2.append("&" + URLEncoder.encode("sigunguCode", "UTF-8") + "=");
		urlBuilder2.append("&" + URLEncoder.encode("eventStartDate", "UTF-8") + "=" + currentDate);
		urlBuilder2.append("&" + URLEncoder.encode("listYN", "UTF-8") + "=Y");
		urlBuilder2.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=ETC");
		urlBuilder2.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=TourAPI3.0_Guide");
		urlBuilder2.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + search.getArrange());
		urlBuilder2.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=10");
		urlBuilder2.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + search.getCurrentPage());

		// arrange A = 제목 , B = 조회순 , C = 수정일순, D = 생성일순,
		// 대표이미지 정렬추가 ( o = 제목순 , p = 조회순 , Q = 수정일순, R = 생성일순)

		URL url2 = new URL(urlBuilder2.toString());
		HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
		conn2.setRequestMethod("GET");
		conn2.setRequestProperty("Content-type", "application/json");
		// System.out.println("Response code: " + conn2.getResponseCode());
		BufferedReader rd2;
		if (conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
			rd2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
		} else {
			rd2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream(), "UTF-8"));
		}
		StringBuilder sb2 = new StringBuilder();
		String line2;
		while ((line2 = rd2.readLine()) != null) {
			sb2.append(line2);
		}
		rd2.close();
		conn2.disconnect();

		Map<String, Object> map = new HashMap<String, Object>();

		List<Festival> list = new ArrayList<Festival>();

		JSONObject jsonobj = (JSONObject) JSONValue.parse(sb2.toString());

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
//				festival.setFestivalImage("no.png");
				festival.setFestivalImage(null);
			} else {
				festival.setFestivalImage(jsonobj5.get("firstimage").toString()); // 원본사진
			}

			if (jsonobj5.get("readcount") == null || jsonobj5.get("readcount") == "") {
				festival.setReadCount("제공정보없음");
			} else {
				festival.setReadCount(jsonobj5.get("readcount").toString());
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

		StringBuilder urlBuilder2 = new StringBuilder(
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword");
		urlBuilder2.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
				+ "=hOlSrH9rpwUcpck4Zl2Wnewju3LzLtgYgAqtW%2FVCRaCJ4BMFUxYFO%2FkzQYu7hbohWd4Z8PWeG9gWgteLzsZqVQ%3D%3D&_type=json");

		urlBuilder2.append("&" + URLEncoder.encode("keyword", "UTF-8") + "="
				+ URLEncoder.encode(search.getSearchKeyword(), "UTF-8"));
		urlBuilder2.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=15");
		urlBuilder2.append("&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + search.getSearchCondition());
		urlBuilder2.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + search.getArrange());
		urlBuilder2.append("&" + URLEncoder.encode("listYN", "UTF-8") + "=Y");
		urlBuilder2.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + search.getCurrentPage());
		urlBuilder2.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=10");
		urlBuilder2.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=ETC");
		urlBuilder2.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=TourAPI3.0_Guide");

		URL url2 = new URL(urlBuilder2.toString());
		HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
		conn2.setRequestMethod("GET");
		conn2.setRequestProperty("Content-type", "application/json");
		// System.out.println("Response code: " + conn2.getResponseCode());
		BufferedReader rd2;
		if (conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
			rd2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
		} else {
			rd2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream(), "UTF-8"));
		}
		StringBuilder sb2 = new StringBuilder();
		String line2;
		while ((line2 = rd2.readLine()) != null) {
			sb2.append(line2);
		}
		rd2.close();
		conn2.disconnect();

		Map<String, Object> map = new HashMap<String, Object>();

		List<Festival> list = new ArrayList<Festival>();

		try {
			JSONObject jsonobj = (JSONObject) JSONValue.parse(sb2.toString());

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
					festival.setFestivalImage("../images/uploadFiles/no.png");
				} else {
					festival.setFestivalImage(jsonobj5.get("firstimage").toString()); // 원본사진
				}

				if (jsonobj5.get("readcount") == null || jsonobj5.get("readcount") == "") {
					festival.setReadCount("제공정보없음");
				} else {
					festival.setReadCount(jsonobj5.get("readcount").toString());
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

					getFestival(this.festival.getFestivalNo());

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

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub

		return sqlSession.selectOne("FestivalMapper.getTotalCount", search);
	}

	@Override
	public Festival getFestivalDB(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("FestivalMapper.getFestivalDB", festivalNo);
	}

	@Override
	public List<Festival> getFestivalListDB(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FestivalMapper.getFestivalListDB", search);
	}

	@Override
	public void addZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.insert("ZzimMapper.addZzim",zzim);
		
	}

	@Override
	public Zzim getZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ZzimMapper.getZzim",zzim);
	}

	@Override
	public void deleteZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("ZzimMapper.deleteZzim",zzim);
		
	}

}
