<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="../common/bootstrap.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath}/resources/css/admin_styles.css">
<title>관리자 페이지</title>
</head>
<body>
 <body>
      <div class="main-container">
          <!-- HEADER -->
          <header class="block">
              <ul class="header-menu horizontal-list">
                  <li>
                      <a class="header-menu-tab" href="#1"><span class="icon entypo-cog scnd-font-color"></span>Settings</a>
                  </li>
                  <li>
                      <a class="header-menu-tab" href="#2"><span class="icon fontawesome-user scnd-font-color"></span>Account</a>
                  </li>
                  <li>
                      <a class="header-menu-tab" href="#3"><span class="icon fontawesome-envelope scnd-font-color"></span>Messages</a>
                      <a class="header-menu-number" href="#4">5</a>
                  </li>
                  <li>
                      <a class="header-menu-tab" href="#5"><span class="icon fontawesome-star-empty scnd-font-color"></span>Favorites</a>
                  </li>
              </ul>
              <div class="profile-menu">
                  <p>Me <a href="#26"><span class="entypo-down-open scnd-font-color"></span></a></p>
                  <div class="profile-picture small-profile-picture">
                      <img width="40px" alt="Anne Hathaway picture" src="https://upload.wikimedia.org/wikipedia/commons/b/b7/SMENTERTAINMENT_LOGO.jpg">
                  </div>
              </div>
          </header>

            <!-- LEFT-CONTAINER --> 
            <div class="left-container container">
                <div class="menu-box block"> <!-- MENU BOX (LEFT-CONTAINER) -->
                    <h2 class="titular">MENU BOX</h2>
                    <ul class="menu-box-menu">
                        <li>
                            <a class="menu-box-tab" href="#6"><span class="icon fontawesome-envelope scnd-font-color"></span>Messages<div class="menu-box-number">24</div></a>                            
                        </li>
                        <li>
                            <a class="menu-box-tab" href="#8"><span class="icon entypo-paper-plane scnd-font-color"></span>Invites<div class="menu-box-number">3</div></a>                            
                        </li>
                        <li>
                            <a class="menu-box-tab" href="#10"><span class="icon entypo-calendar scnd-font-color"></span>Events<div class="menu-box-number">5</div></a>                            
                        </li>
                        <li>
                            <a class="menu-box-tab" href="#12"><span class="icon entypo-cog scnd-font-color"></span>Account Settings</a>
                        </li>
                        <li>
                            <a class="menu-box-tab" href="#13"><sapn class="icon entypo-chart-line scnd-font-color"></sapn>Statistics</a>
                        </li>                        
                    </ul>
                </div>
                <div class="donut-chart-block block"> <!-- DONUT CHART BLOCK (LEFT-CONTAINER) -->
                    <h2 class="titular">OS AUDIENCE STATS</h2>
                    <div class="donut-chart">
                        <!-- DONUT-CHART by @kseso http://codepen.io/Kseso/pen/phiyL -->
                        <div id="porcion1" class="recorte"><div class="quesito ios" data-rel="21"></div></div>
                        <div id="porcion2" class="recorte"><div class="quesito mac" data-rel="39"></div></div>
                        <div id="porcion3" class="recorte"><div class="quesito win" data-rel="31"></div></div>
                        <div id="porcionFin" class="recorte"><div class="quesito linux" data-rel="9"></div></div>
                        <!-- END DONUT-CHART by @kseso http://codepen.io/Kseso/pen/phiyL -->    
                        <p class="center-date">JUNE<br><span class="scnd-font-color">2013</span></p> 
                    </div>
                    <ul class="os-percentages horizontal-list">
                        <li>
                            <p class="ios os scnd-font-color">iOS</p>
                            <p class="os-percentage">21<sup>%</sup></p>
                        </li>
                        <li>
                            <p class="mac os scnd-font-color">Mac</p>
                            <p class="os-percentage">48<sup>%</sup></p>
                        </li>
                        <li>
                            <p class="linux os scnd-font-color">Linux</p>
                            <p class="os-percentage">9<sup>%</sup></p>
                        </li>
                        <li>
                            <p class="win os scnd-font-color">Win</p>
                            <p class="os-percentage">32<sup>%</sup></p>
                        </li>
                    </ul>
                </div>
                <div class="line-chart-block block clear"> <!-- LINE CHART BLOCK (LEFT-CONTAINER) -->
                    <div class="line-chart">
                      <!-- LINE-CHART by @kseso http://codepen.io/Kseso/pen/phiyL -->
                        <div class='grafico'>
                           <ul class='eje-y'>
                             <li data-ejeY='30'></li>
                             <li data-ejeY='20'></li>
                             <li data-ejeY='10'></li>
                             <li data-ejeY='0'></li>
                           </ul>
                           <ul class='eje-x'>
                             <li>Apr</li>
                             <li>May</li>
                             <li>Jun</li>
                           </ul>
                             <span data-valor='25'>
                               <span data-valor='8'>
                                 <span data-valor='13'>
                                   <span data-valor='5'>   
                                     <span data-valor='23'>   
                                     	<span data-valor='12'>
                                        	<span data-valor='15'>
                                         	</span>
                                        </span>
                                      </span>
                                     </span>
                                   </span>
                                  </span>
                                </span>
                        </div>
                        <!-- END LINE-CHART by @kseso http://codepen.io/Kseso/pen/phiyL -->
                    </div>
                    <ul class="time-lenght horizontal-list">
                        <li><a class="time-lenght-btn" href="#14">Week</a></li>
                        <li><a class="time-lenght-btn" href="#15">Month</a></li>
                        <li><a class="time-lenght-btn" href="#16">Year</a></li>
                    </ul>
                    <ul class="month-data clear">
                        <li>
                            <p>APR<span class="scnd-font-color"> 2013</span></p>
                            <p><span class="entypo-plus increment"> </span>21<sup>%</sup></p>
                        </li>
                        <li>
                            <p>MAY<span class="scnd-font-color"> 2013</span></p>
                            <p><span class="entypo-plus increment"> </span>48<sup>%</sup></p>
                        </li>
                        <li>
                            <p>JUN<span class="scnd-font-color"> 2013</span></p>
                            <p><span class="entypo-plus increment"> </span>35<sup>%</sup></p>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- MIDDLE-CONTAINER -->
            <div class="middle-container container">
                <div class="profile block"> <!-- PROFILE (MIDDLE-CONTAINER) -->
                    <a class="add-button" href="#28"><span class="icon entypo-plus scnd-font-color"></span></a>
                    <div class="profile-picture big-profile-picture clear">
                        <img width="150px" alt="SM Entertainment" src="https://mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/6b6df562068177.5a83b6bd94046.jpg" >
                    </div>
                    <h1 class="user-name">SM Entertainment</h1>
                    <div class="profile-description">
                        <p class="scnd-font-color">Copyrightⓒ2019 SM ENTERTAINMENT Co., Ltd. All rights reserved.</p>
                    </div>
                    <ul class="profile-options horizontal-list">
                        <li><a class="comments" href="#40"><p><span class="icon fontawesome-comment-alt scnd-font-color"></span>23</li></p></a>
                        <li><a class="views" href="#41"><p><span class="icon fontawesome-eye-open scnd-font-color"></span>841</li></p></a>
                        <li><a class="likes" href="#42"><p><span class="icon fontawesome-heart-empty scnd-font-color"></span>49</li></p></a>
                    </ul>
                </div>
                <div class="weather block clear"> <!-- WEATHER (MIDDLE-CONTAINER) -->
                    <h2 class="titular"><span class="icon entypo-location"></span><strong>CLUJ-NAPOCA</strong>/RO</h2>
                    <div class="current-day">
                        <p class="current-day-date">FRI 29/06</p>
                        <p class="current-day-temperature">24º<span class="icon-cloudy"></span></p>
                    </div>
                    <ul class="next-days">
                        <li>
                            <a href="#43">
                                <p class="next-days-date"><span class="day">SAT</span> <span class="scnd-font-color">29/06</span></p>
                                <p class="next-days-temperature">25º<span class="icon icon-cloudy scnd-font-color"></span></p>
                            </a>
                        </li>
                        <li>
                            <a href="#44">
                                <p class="next-days-date"><span class="day">SUN</span> <span class="scnd-font-color">30/06</span></p>
                                <p class="next-days-temperature">22º<span class="icon icon-cloudy2 scnd-font-color"></span></p>
                            </a>
                        </li>
                        <li>
                            <a href="#45">
                                <p class="next-days-date"><span class="day">MON</span> <span class="scnd-font-color">01/07</span></p>
                                <p class="next-days-temperature">24º<span class="icon icon-cloudy2 scnd-font-color"></span></p>
                            </a>
                        </li>
                        <li>
                            <a href="#46">
                                <p class="next-days-date"><span class="day">TUE</span> <span class="scnd-font-color">02/07</span></p>
                                <p class="next-days-temperature">26º<span class="icon icon-cloudy scnd-font-color"></span></p>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <p class="next-days-date"><span class="day">WED</span> <span class="scnd-font-color">03/07</span></p>
                                <p class="next-days-temperature">27º<span class="icon icon-sun scnd-font-color"></span></p>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <p class="next-days-date"><span class="day">THU</span> <span class="scnd-font-color">04/07</span></p>
                                <p class="next-days-temperature">29º<span class="icon icon-sun scnd-font-color"></span></p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- RIGHT-CONTAINER -->
            <div class="right-container container">
                <div class="calendar-month block"> <!-- CALENDAR MONTH (RIGHT-CONTAINER) -->
                    <div class="arrow-btn-container">
                        <a class="arrow-btn left" href="#202"><span class="icon fontawesome-angle-left"></span></a>
                        <h2 class="titular">APRIL 2013</h2>
                        <a class="arrow-btn right" href="#203"><span class="icon fontawesome-angle-right"></span></a>
                    </div>
                    <table class="calendar">
                        <thead class="days-week">
                            <tr>
                                <th>S</th>
                                <th>M</th>
                                <th>T</th>
                                <th>W</th>
                                <th>R</th>
                                <th>F</th>
                                <th>S</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><a class="scnd-font-color" href="#100">1</a></td>
                            </tr>
                            <tr>
                                <td><a class="scnd-font-color" href="#101">2</a></td>
                                <td><a class="scnd-font-color" href="#102">3</a></td>
                                <td><a class="scnd-font-color" href="#103">4</a></td>
                                <td><a class="scnd-font-color" href="#104">5</a></td>
                                <td><a class="scnd-font-color" href="#105">6</a></td>
                                <td><a class="scnd-font-color" href="#106">7</a></td>
                                <td><a class="scnd-font-color" href="#107">8</a></td>
                            </tr>
                            <tr>
                                <td><a class="scnd-font-color" href="#108">9</a></td>
                                <td><a class="scnd-font-color" href="#109">10</a></td>
                                <td><a class="scnd-font-color" href="#110">11</a></td>
                                <td><a class="scnd-font-color" href="#111">12</a></td>
                                <td><a class="scnd-font-color" href="#112">13</a></td>
                                <td><a class="scnd-font-color" href="#113">14</a></td>
                                <td><a class="scnd-font-color" href="#114">15</a></td>
                            </tr>
                            <tr>
                                <td><a class="scnd-font-color" href="#115">16</a></td>
                                <td><a class="scnd-font-color" href="#116">17</a></td>
                                <td><a class="scnd-font-color" href="#117">18</a></td>
                                <td><a class="scnd-font-color" href="#118">19</a></td>
                                <td><a class="scnd-font-color" href="#119">20</a></td>
                                <td><a class="scnd-font-color" href="#120">21</a></td>
                                <td><a class="scnd-font-color" href="#121">22</a></td>
                            </tr>
                            <tr>
                                <td><a class="scnd-font-color" href="#122">23</a></td>
                                <td><a class="scnd-font-color" href="#123">24</a></td>
                                <td><a class="scnd-font-color" href="#124">25</a></td>
                                <td><a class="today" href="#125">26</a></td>
                                <td><a href="#126">27</a></td>
                                <td><a href="#127">28</a></td>
                                <td><a href="#128">29</a></td>
                            </tr>
                            <tr>
                                <td><a href="#129">30</a></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div> <!-- end calendar-month block --> 
                <div class="loading block"> <!-- LOADING (RIGHT-CONTAINER) -->
                    <div class="progress-bar downloading"></div>
                    <p><span class="icon fontawesome-cloud-download scnd-font-color"></span>Downloading...</p>
                    <p class="percentage">81<sup>%</sup></p>
                    <div class="progress-bar uploading"></div>
                    <p><span class="icon fontawesome-cloud-upload scnd-font-color"></span>Uploading...</p>
                    <p class="percentage">43<sup>%</sup></p>
                </div>
                <div class="calendar-day block"> <!-- CALENDAR DAY (RIGHT-CONTAINER) -->
                    <div class="arrow-btn-container">
                        <a class="arrow-btn left" href="#200"><span class="icon fontawesome-angle-left"></span></a>
                        <h2 class="titular">WEDNESDAY</h2>
                        <a class="arrow-btn right" href="#201"><span class="icon fontawesome-angle-right"></span></a>
                    </div>
                        <p class="the-day">26</p>
                        <a class="add-event button" href="#27">ADD EVENT</a>
                </div>
            </div> <!-- end right-container -->
        </div> <!-- end main-container -->
    </body>
</body>
</html>