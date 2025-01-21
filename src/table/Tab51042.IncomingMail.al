table 51042 "Incoming Mail"
{
    // LookupPageId = sharepoi;
    // DrillDownPageId = SharePoint;

    fields
    {
        field(1; "Ref No"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Date Received" := Today;
                "Received By" := UserId;
            end;
        }
        field(5; "Date Received"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; Media; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Mail Content"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "1st Comment"; text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "2nd Comment"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

        field(10; status; Option)
        {
            OptionMembers = Open,Pending,Approved,Cancelled;
            // Editable = false;
        }
        field(11; "Incoming Mail"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Department; Code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(13; "Received By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Mail Subject"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document type"; Option)
        {
            OptionMembers = ,PV,"Imprest Surrender","Incoming Mail","Imprest Requisition",Memo,Receipt,Claim,"Petty Cash","Purchase Invoice","Purchase Credit Memo","Procurement Plan","Purchase Memo","Purchase Requisition","Purchase Quotes","Purchase Order","Indirect Process LPO NO","Tendering","Staff File","Training Card",Welfare,Disciplinary,Drivers,"Transport Requisition","Fuel Requisition","Students Attachments","Institution Attachments","Reccurrent Application","Disbursment ";
            DataClassification = ToBeClassified;
        }
        field(16; Type; Option)
        {
            OptionMembers = Confidential,"Non-Confidential";
        }
        field(17; "Assing User"; Code[20])
        {
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            begin

            end;
        }
        field(18; "Name"; text[200])
        {

        }
        field(19; UserId; code[20])
        {

        }
    }
    keys
    {
        key(pk; "Ref No")
        {
            Clustered = true;
        }
    }
    var
        hrmEmp: Record "HRM-Employee C";
        EmailBody: Text;
        EmailSubject: Text;
        "E-Mail": Text;

    local procedure Send()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee C";
        progLeader: text;
        mail: Text;
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(mail);
        mail := "E-Mail";
        EmailBody := 'Hello, Please log into the system and view correspondace for your review';
        EmailSubject := 'CORRESPONDACE NOTIFICATION';
        SendMail.Create(mail, EmailSubject, EmailBody);
        emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
    end;

}
