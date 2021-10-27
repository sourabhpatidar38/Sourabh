using System;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;

namespace Sourabh_CRUD
{
    public partial class CRUD : Form
    {
        public CRUD()
        {
            InitializeComponent();
        }

        SqlConnection con = new SqlConnection(@"Data Source=INSVR-INF-RDS10;Initial Catalog=projectsql;Integrated Security=True;Pooling=False");

        public int CustomerId;

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void button8_Click(object sender, EventArgs e)
        {
            if (CustomerId > 0)
            {
                SqlCommand cmd = new SqlCommand("update customer_new set customer_name=@name,customer_phone=@phone,customer_email=@email where customer_id=@ID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@name", textName.Text);
                cmd.Parameters.AddWithValue("@phone", textPhone.Text);
                cmd.Parameters.AddWithValue("@email", textEmail.Text);
                cmd.Parameters.AddWithValue("@ID", this.CustomerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                MessageBox.Show("Information is Update Successfully", "Update", MessageBoxButtons.OK, MessageBoxIcon.Information);

                GetStudentRecord();
                ResetControls();
            }
            else
            {
                MessageBox.Show("Select for Update", "Select ?", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (isValid())
            {
                SqlCommand cmd = new SqlCommand("insert into customer_new values(@name,@phone,@email)", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@name", textName.Text);
                cmd.Parameters.AddWithValue("@phone", textPhone.Text);
                cmd.Parameters.AddWithValue("@email", textEmail.Text);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                MessageBox.Show("New Customer is Successfully Saved in the Database", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);

                GetStudentRecord();
                ResetControls();



            }
        }

        private bool isValid()
        {
            if (textName.Text == string.Empty)
            {
                MessageBox.Show("Name is Required", "Faild", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false; 
            }
            if (textPhone.Text == string.Empty)
            {
                MessageBox.Show("Phone Number is Required", "Faild", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            if (textEmail.Text == string.Empty)
            {
                MessageBox.Show("Email is Required", "Faild", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }

            return true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            if (CustomerId > 0)
            {
                SqlCommand cmd = new SqlCommand("delete customer_new where customer_id=@ID", con);
                cmd.CommandType = CommandType.Text;
               
                cmd.Parameters.AddWithValue("@ID", this.CustomerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                MessageBox.Show("Information is Deleted Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);

                GetStudentRecord();
                ResetControls();
            }
            else
            {
                MessageBox.Show("Select for Delete", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            ResetControls();
        }

        private void ResetControls()
        {
            CustomerId = 0;
            textName.Clear();
            textPhone.Clear();
            textEmail.Clear();
            textName.Focus();
        }

        private void CRUD_Load(object sender, EventArgs e)
        {
            GetStudentRecord();
        }

        private void GetStudentRecord()
        {
            
            SqlCommand cmd = new SqlCommand("Select * from customer_new", con);
            DataTable dt = new DataTable();

            con.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            dt.Load(sdr);
            con.Close();

            CustomerData.DataSource = dt;


        }


        private void textMobile_TextChanged(object sender, EventArgs e)
        {

        }

        private void CustomerData_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            CustomerId = Convert.ToInt32(CustomerData.SelectedRows[0].Cells[0].Value);
            textName.Text = CustomerData.SelectedRows[0].Cells[1].Value.ToString();
            textPhone.Text = CustomerData.SelectedRows[0].Cells[2].Value.ToString();
            textEmail.Text = CustomerData.SelectedRows[0].Cells[3].Value.ToString();
        }
    }
}
