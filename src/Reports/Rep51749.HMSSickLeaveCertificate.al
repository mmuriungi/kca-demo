report 51903 "HMS Sick Leave Certificate"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMS Sick Leave Certificate.rdl';
    Caption = 'Sick Leave Certificate';

    dataset
    {
        dataitem("HMS-Off Duty"; "HMS-Off Duty")
        {
            column(Certificate_No; "Certificate No.")
            {
            }
            column(Certificate_Date; Format("Certificate Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Title; Title)
            {
            }
            column(Staff_Name; "Staff Name")
            {
            }
            column(PF_No; "PF No.")
            {
            }
            column(Student_No; "Student No.")
            {
            }
            column(Department; Department)
            {
            }
            column(Sick_Leave_Duration; "Sick Leave Duration")
            {
            }
            column(Duration_Unit; Format("Duration Unit"))
            {
            }
            column(Duration_Text; GetDurationText())
            {
            }
            column(Off_Duty_Start_Date; Format("Off Duty Start Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Review_Date; Format("Review Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Chief_Medical_Officer; "Chief Medical Officer")
            {
            }
            column(Illness_Description; "Illness Description")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(TitleText; GetTitleText())
            {
            }
            column(IdentificationText; GetIdentificationText())
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        
    local procedure GetDurationText(): Text
    begin
        if "HMS-Off Duty"."Duration Unit" = "HMS-Off Duty"."Duration Unit"::Days then
            exit(Format("HMS-Off Duty"."Sick Leave Duration") + ' Days')
        else
            exit(Format("HMS-Off Duty"."Sick Leave Duration") + ' Weeks');
    end;
    
    local procedure GetTitleText(): Text
    begin
        case "HMS-Off Duty".Title of
            "HMS-Off Duty".Title::Prof:
                exit('Prof.');
            "HMS-Off Duty".Title::Dr:
                exit('Dr.');
            "HMS-Off Duty".Title::Mr:
                exit('Mr.');
            "HMS-Off Duty".Title::Mrs:
                exit('Mrs.');
            "HMS-Off Duty".Title::Miss:
                exit('Miss');
            else
                exit('');
        end;
    end;
    
    local procedure GetIdentificationText(): Text
    begin
        if "HMS-Off Duty"."PF No." <> '' then
            exit('PF No.: ' + "HMS-Off Duty"."PF No.")
        else if "HMS-Off Duty"."Student No." <> '' then
            exit('Student No.: ' + "HMS-Off Duty"."Student No.")
        else
            exit('');
    end;
}