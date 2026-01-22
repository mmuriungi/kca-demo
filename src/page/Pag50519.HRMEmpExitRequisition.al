page 50519 "HRM-Emp. Exit Requisition"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HRM-Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Clearance No"; Rec."Exit Clearance No")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                }
                field("Station Code"; Rec."Station Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                    ApplicationArea = all;
                }
                field("Nature Of Separation"; Rec."Nature Of Separation")
                {
                    ApplicationArea = all;
                }
                field("Reason For Leaving (Other)"; Rec."Reason For Leaving (Other)")
                {
                    ApplicationArea = all;
                }
                field("Date Of Clearance"; Rec."Date Of Clearance")
                {
                    ApplicationArea = all;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = all;
                }
                field("Form Submitted"; Rec."Form Submitted")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
                ApplicationArea = all;
            }
            systempart(Control1102755010; Notes)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
            }
            action("&Approvals")
            {
                Caption = '&Approvals';
                Enabled = true;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;

                trigger OnAction()
                begin
                    ApprovalEntries.Setfilters(DATABASE::"Misc. Article Information", DocumentType, ExitCl."Exit Clearance No");
                    ApprovalEntries.Run;
                end;
            }
            action("&Send Approval Request")
            {
                Caption = '&Send Approval Request';
                Enabled = true;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;

                trigger OnAction()
                begin

                    if Confirm('Send this Exit Request for Approval?', true) = false then exit;

                    //ApprovalMgt.SendExitApprovalReq(Rec);
                end;
            }
            action("&Cancel Approval Request")
            {
                Caption = '&Cancel Approval Request';
                Enabled = true;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;

                trigger OnAction()
                begin
                    // IF CONFIRM('Cancel this Exit request Approval',TRUE)=FALSE THEN EXIT;
                    //ApprovalMgt.CancelExitAppRequest(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get(Rec."Employee No.") then begin
            JobTitle := HREmp."Job Title";
            sUserID := HREmp."User ID";
        end else begin
            JobTitle := '';
            sUserID := '';
        end;


        Rec.SetRange("Employee No.");
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        RecalcDates;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record "HRM-Employee C";
        Dates: Codeunit "HR Dates";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "HRM-Employee (C)";
        sUserID: Code[30];
        DoclLink: Record "HRM-Employee Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        ExitCl: Record "HRM-Employee Exit Interviews";
        Text19062217: Label 'Misc Articles';
        DepartmentName: Text[40];
        sDate: Date;
        Number: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Medical Claims";
        ApprovalEntries: Page "HR-Approval Entries";
        //todo  ApprovalMgt: Codeunit "Approvals Management";
        Department: Record "Dimension Value";

    procedure RecalcDates()
    begin
        //Recalculate Important Dates
        if (HREmp."Date Of Leaving" = 0D) then begin
            if (HREmp."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(HREmp."Date Of Birth", Today);
            if (HREmp."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(HREmp."Date Of Join", Today);
            /* IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
             DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",TODAY);
             IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
             DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",TODAY);  */
            //MODIFY;
        end else begin
            if (HREmp."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(HREmp."Date Of Birth", HREmp."Date Of Leaving");
            if (HREmp."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(HREmp."Date Of Join", HREmp."Date Of Leaving");
            /* IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
             DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",HREmp."Date Of Leaving");
             IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
             DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",HREmp."Date Of Leaving");*/
            //MODIFY;
        end;

    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        Rec.FilterGroup := 2;
        ExitCl.SetRange(ExitCl."Employee No.", Rec."Employee No.");
        Rec.FilterGroup := 0;
        if ExitCl.Find('-') then;
        CurrPage.Update(false);
    end;
}

