using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for NumberHelper
/// </summary>
public static class NumberHelper
{
	public static decimal? ConvertToDecimal(string input){
        decimal? output = null;
        if (!String.IsNullOrEmpty(input.Trim())) {
            output = decimal.Parse(input.Trim());
        }
        return output;
    }
}