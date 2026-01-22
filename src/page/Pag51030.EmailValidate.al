page 51030 "Email Validate"
{
    Caption = 'Email Validate';
    PageType = List;
    SourceTable = UpdateEmail;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(lineNo; Rec.lineNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lineNo field.', Comment = '%';
                }
                field(indexNo; Rec.indexNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the indexNo field.', Comment = '%';
                }
                field(adm; Rec.adm)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the adm field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Email")
            {
                ApplicationArea = All;
                trigger onAction()
                begin
                    updateEmail();
                end;
            }
        }
    }
    var
        apps: Record "ACA-Applic. Form Header";
        updates: Record UpdateEmail;
        kuccps: Record "KUCCPS Imports";

    procedure updateEmail()
    begin
        apps.Reset();
        apps.SetRange("Settlement Type", 'GSS');
        if apps.Find('-') then begin
            repeat
                updates.Reset();
                updates.SetRange(indexNo, apps."Index Number");
                if updates.Find('-') then begin
                    //apps."Student E-mail" := updates.indexNo + '@student.karu.ac.ke';
                    apps."Other Names" := updates.adm;
                    apps.Modify();
                end;
            until apps.Next() = 0;
        end;
        kuccps.Reset();
        kuccps.SetRange("KUCCPS Batch", '2024');
        if kuccps.Find('-') then begin
            repeat
                updates.Reset();
                updates.SetRange(indexNo, kuccps.Index);
                if updates.Find('-') then begin
                    kuccps."Middle Name" := updates.adm;
                    kuccps.Modify();
                end;
            until kuccps.Next() = 0;
        end;

    end;
}
