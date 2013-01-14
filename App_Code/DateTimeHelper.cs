using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;

/// <summary>
/// Summary description for DateTimeHelper
/// </summary>
public static class DateTimeHelper
{

    public static string ConvertToString(string inputDateTime)
    {
        DateTime outputDateTime;
        string result = "";
        result = DateTime.TryParse(inputDateTime, out outputDateTime) ? DateTime.Parse(inputDateTime).ToString("dd-MM-yyyy") : inputDateTime;
        return result;
    }

    public static DateTime? ConvertToDate(string inputDateTime)
    {
        DateTime outputDateTime;
        DateTime? result = null;
        if (DateTime.TryParseExact(inputDateTime, "dd-MM-yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out outputDateTime)) {
            result = outputDateTime;
        }
        return result;
    }

    public static string ToTimeStamp() {
        return DateTime.Now.ToString("yyyyddMMHHmmss");
    }

    public static void GetStartAndEndTime(string inputDate, out DateTime startTime, out DateTime endTime) {
        var start = inputDate.Split('-')[2] + "-" + inputDate.Split('-')[1] + "-" + inputDate.Split('-')[0] + " 00:00:00";
        var end = inputDate.Split('-')[2] + "-" + inputDate.Split('-')[1] + "-" + inputDate.Split('-')[0] + " 23:59:59";
        startTime = DateTime.Parse(start);
        endTime = DateTime.Parse(end);
    }
}