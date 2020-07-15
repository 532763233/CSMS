var time = new Date();
var year = time.getFullYear();
var month = (time.getMonth()+1).toString().padStart(2,'0');
var date = time.getDate().toString().padStart(2,'0');//系统时间月份中的日
var day = time.getDay();//系统时间中的星期值
var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
var week = weeks[day];//显示为星期几
var hour = time.getHours().toString().padStart(2,'0');
var minutes = time.getMinutes().toString().padStart(2,'0');
var seconds = time.getSeconds().toString().padStart(2,'0');

var getday=year+"-"+month+"-"+date;
var gettime=hour+":"+minutes+":"+seconds;
var now =year+"年"+month+"月"+date+"日 "+week +" "+gettime;