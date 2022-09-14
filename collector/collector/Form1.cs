using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Windows.Forms;

namespace collector
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void collect_Click(object sender, EventArgs e)
        {
                FolderBrowserDialog dlg = new FolderBrowserDialog();
                dlg.ShowDialog();
                textBox1.Text = dlg.SelectedPath;

                DirectoryInfo dir_info = new DirectoryInfo(dlg.SelectedPath);
                string directory = dir_info.Name;

                string filePath = @dlg.SelectedPath + "meta.txt";

                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }

                var files = System.IO.Directory.GetFiles(dlg.SelectedPath, "*.*", System.IO.SearchOption.AllDirectories);

                using (StreamWriter sw = File.CreateText(filePath))
                {
                    foreach (string index in files)
                    {
                        string fileName = @index;
                        string fileModel = @index;
                        string result;
                        result = Path.GetFileName(fileName);
                        int fileExtPos = result.LastIndexOf(".");
                        if (fileExtPos >= 0)
                            fileModel = result.Substring(0, fileExtPos);

                        sw.WriteLine("<file src='" + directory + "/" + result + "' download='false' model='" + fileModel + "'/>");
                    }
                }

                MessageBox.Show("models collected to 'meta.txt'", "success");
        }
    }
}
