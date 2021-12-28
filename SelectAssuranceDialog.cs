using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace Alchemy
{
    public partial class SelectAssuranceDialog : Form
    {
        private double assurance = 0.95;
        public double Assurance {
            get
            {
                return assurance / 100;
            }
        }
        public SelectAssuranceDialog()
        {
            InitializeComponent();
        }


        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void assuranceTextBox_TextChanged(object sender, EventArgs e)
        {
            try
            {
                assurance = double.Parse(assuranceTextBox.Text);
            }
            catch (Exception)
            {

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.OK;
            Close();
        }
    }
}
