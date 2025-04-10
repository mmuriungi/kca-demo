table 51317 "Treatment"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            //Caption = 'CE No';
            AutoIncrement = true;
        }
        field(2; "Entry No"; Integer)
        {
            TableRelation = "Causes & Effects2";
        }
        field(3; "Risk Details Line"; Code[90])
        {
            Caption = 'Risk Details Line';
            TableRelation = "Risk Details";
        }
        field(4; "Treatment (risk champion suggestions)"; Text[250])
        {
            // Caption = 'Causes';
        }
        field(5; "Action points (risk owner in point form) To have a treatment action plan on the side"; Text[250])
        {
            // Caption = 'Effects';
        }
        field(6; "Areas to review (risk champion)-evidences"; Text[130])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Responsibility (for each action plan)"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            var
                ObjEmpl: Record "HRM-Employee C";
            begin
                ObjEmpl.Reset();
                ObjEmpl.SetRange(ObjEmpl."No.", "Responsibility (for each action plan)");
                if ObjEmpl.FindFirst() then begin
                    "Responsibility Name" := ObjEmpl."Search Name";
                    Email := ObjEmpl."E-Mail";
                end;
            end;
        }
        field(8; "Timelines(when I will be carried out)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Remarks; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Responsibility Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Email; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Causes; Text[250])
        {
            Caption = 'Causes';
            FieldClass = FlowField;
            CalcFormula = lookup("Causes & Effects2".Causes where("Entry No" = field("Entry No")));
        }
        field(13; Effects; Text[250])
        {
            Caption = 'Effects';
            FieldClass = FlowField;
            CalcFormula = lookup("Causes & Effects2".Effects where("Entry No" = field("Entry No")));
        }
    }
    keys
    {
        key(PK; "Entry No.", "Risk Details Line", "Entry No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        ObjCausesEffects: Record "Causes & Effects2";
    begin
        // ObjCausesEffects.Reset();
        // ObjCausesEffects.SetRange(ObjCausesEffects."Entry No", "Entry No");
        // if ObjCausesEffects.FindFirst() then begin
        //     ObjCausesEffects.Causes := Causes;
        //     ObjCausesEffects.Effects := Effects;
        //
        //   ObjCausesEffects.Modify();
        // end;
    end;

    procedure FnReportTreatment(var ObjeTreatment: record Treatment; MyRecipients: Text[500])
    var

        // CuEmailMessage: Codeunit "Email Message";
        // CuEmail: Codeunit Email;
        LblMailBody: Label ' Treatment Has been Reported. Kind Regards, KEPHIS';
        FilePath: Text[250];
        FileName: Text[250];
        Body: Label 'Treatment Has been Reported';
        //TbGeneralSetups: record "General Setups";
        CompanyInfo: record "Company Information";
        EmailAddress: Text[250];
        CompName: Text[250];
        Receipient: Text[250];
        TbUserSetup: record "User Setup";
        Subject: Text;
        SenderName: Text;
        EmailBody: Text[3000];
        // Base64: Codeunit "Base64 Convert";
        MyRecordRef: RecordRef;
        MyInStream: InStream;
        MyOutStream: OutStream;
        // CuTempBlob: codeunit "Temp Blob";
        MyBase64: Text;
        NotifHandler: codeunit "Notifications Handler";
    // SMTPMail:Codeunit email

    begin

        // ObjRiskHeader.CalcFields(ObjRegistration."E-Mail");
        if ObjeTreatment.Email <> '' then begin

            // CuTempBlob.CreateOutStream(MyOutStream);
            ObjeTreatment.Reset();
            ObjeTreatment.Setrange("Entry No.", ObjeTreatment."Entry No.");
            if ObjeTreatment.FindFirst() then begin


                EmailBody := StrSubstNo('Dear, ' + ' ' + '' + ObjeTreatment."Responsibility Name" + ' ' + ' You have been assigned the task of addressing the risk related to ' + '' + ObjeTreatment."Treatment (risk champion suggestions)" + '' + ' through a treatment, ' + ' ' + '' + ObjeTreatment."Action points (risk owner in point form) To have a treatment action plan on the side" + ' ' + ' ' + ' Your prompt action on this matter is appreciated. The deadline for completing this treatment is,  ' + ' ' + ' ' + Format(ObjeTreatment."Timelines(when I will be carried out)"), LblMailBody);

                Subject := 'Reported Treatment';

                NotifHandler.FnSendEmail('', 'TREATMENT', StrSubstNo(EmailBody, ObjeTreatment."Entry No.", ObjeTreatment."Timelines(when I will be carried out)"),
                       ObjeTreatment.Email, '', '', false, '', '', '');
                Message('Notification Sent');
                //
            end;
        end;
    end;

}
