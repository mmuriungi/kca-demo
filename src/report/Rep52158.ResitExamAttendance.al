report 52158 "Resit Exam Attendance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ResitExamAttendance.rdl';
    dataset
    {
        dataitem(resit; "Aca-Special Exams Details")
        {
            RequestFilterFields = Programme, Stage, "Current Semester", "Current Academic Year", "Unit Code", "Academic Year", Semester;

            column(AcademicYear_resit; "Academic Year")
            {
            }
            column(Semester_resit; Semester)
            {
            }
            column(ExamSession_resit; "Exam Session")
            {
            }
            column(StudentNo_resit; "Student No.")
            {
            }
            column(Stage_resit; Stage)
            {
            }
            column(Programme_resit; Programme)
            {
            }
            column(UnitCode_resit; "Unit Code")
            {
            }
            column(UnitDescription_resit; "Unit Description")
            {
            }
            column(Status_resit; Status)
            {
            }
            column(CATMarks_resit; "CAT Marks")
            {
            }
            column(ExamMarks_resit; "Exam Marks")
            {
            }
            column(TotalMarks_resit; "Total Marks")
            {
            }
            column(Grade_resit; Grade)
            {
            }
            column(CostPerExam_resit; "Cost Per Exam")
            {
            }
            column(Catogory_resit; Catogory)
            {
            }
            column(CurrentAcademicYear_resit; "Current Academic Year")
            {
            }
            column(ChargePosted_resit; "Charge Posted")
            {
            }
            column(CurrentSemester_resit; "Current Semester")
            {
            }
            column(logo; info.Picture)
            {

            }
            column(cname; info.Name)
            {

            }
            column(caddress; info.Address)
            {

            }
            column(cmail; info."E-Mail")
            {

            }
            column(curl; info."Home Page")
            {

            }
            column(cphone; info."Phone No.")
            {

            }
            column(progname; progname)
            {

            }
            column(studname; studname)
            {

            }

            trigger OnAfterGetRecord()
            begin
                info.get;
                info.CalcFields(Picture);
                prog.Reset();
                prog.SetRange("Code", resit.Programme);
                if prog.Find('-') then
                    progname := prog.Description;

                cust.Reset();
                cust.SetRange("No.", resit."Student No.");
                if cust.Find('-') then
                    studname := cust.Name;
            end;
        }
    }

    var
        info: Record "Company Information";
        prog: Record "ACA-Programme";
        cust: Record Customer;
        progname: Text[100];
        studname: Text[100];



}