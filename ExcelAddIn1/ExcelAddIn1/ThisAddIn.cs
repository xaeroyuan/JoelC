using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using Excel = Microsoft.Office.Interop.Excel;
using Office = Microsoft.Office.Core;
using Microsoft.Office.Tools.Excel;
using System.Windows.Forms;

namespace ExcelAddIn1
{
    public partial class ThisAddIn
    {
        private void ThisAddIn_Startup(object sender, System.EventArgs e)
        {
            m_result = new Dictionary<string, int>();
            this.Application.WorkbookOpen += Application_WorkbookOpen;

        }

        private void Application_WorkbookNewSheet(Excel.Workbook Wb, object Sh)
        {
            Excel.Worksheet sheet = (Excel.Worksheet)Sh;
            sheet.Name = "result";
            var data = new object[m_result.Count, 2];
            int row = 0;
            foreach (KeyValuePair<string, int> it in m_result)
            {
                data[row, 0] = it.Key;
                data[row, 1] = it.Value;
                row++;
            }
            var startCell = (Excel.Range)sheet.Cells[1, 1];
            var endCell = (Excel.Range)sheet.Cells[m_result.Count, 2];
            var writeRange = sheet.Range[startCell, endCell];
            writeRange.Value2 = data;
        }

        private void Application_WorkbookOpen(Excel.Workbook Wb)
        {
            Wb.SheetSelectionChange += Wb_SheetSelectionChange;
            this.Application.WorkbookNewSheet += Application_WorkbookNewSheet;
        }

        private void Wb_SheetSelectionChange(object Sh, Excel.Range Target)
        {
            for (int row = 0; row < Target.Rows.Count && row < 2000; ++row)
                for (int column = 0; column < Target.Columns.Count; ++column)
                {
                    var v = ((Excel.Range)Target.Cells[row + 1, column + 1]).Value2;
                    if(v == null)
                    {
                        continue;
                    }
                    string text = v.ToString();
                    char[] spliter = { ' ', '\n' };
                    string[] res = text.Split(spliter);
                    foreach(string r in res)
                    {
                        var starIndex = r.LastIndexOf('*');
                        if (starIndex == -1)
                        {
                            continue;
                        }
                        string key = r.Substring(0, starIndex - 0);
                        string va = r.Substring(starIndex + 1);
                        int vi;
                        if (!Int32.TryParse(va, out vi))
                        {
                            MessageBox.Show("Data errors: %s", text);
                            m_result.Clear();
                            break;
                        }
                        else
                        {
                            if (!m_result.ContainsKey(key))
                            {
                                m_result[key] = vi;
                            }
                            else
                            {
                                m_result[key] += vi;
                            }
                        }
                    }

                }
            if(m_result.Count > 0)
            {
                Excel.Worksheet sheet = this.Application.ActiveWorkbook.Worksheets.Add();
            }
            else
            {
                MessageBox.Show("make sure you select correct column");
            }
           
        }

        private void ThisAddIn_Shutdown(object sender, System.EventArgs e)
        {
            m_result = null;
        }


        private Dictionary<string, int> m_result;

        #region VSTO generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InternalStartup()
        {
            this.Startup += new System.EventHandler(ThisAddIn_Startup);
            this.Shutdown += new System.EventHandler(ThisAddIn_Shutdown);
        }
        
        #endregion
    }
}
