page 51053 "Lect Load Batch Card"
{
    DataCaptionFields = "Semester Code", Status, "Created By";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Lect Load Batches";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    Editable = semedit;
                    ApplicationArea = All;
                }
                field("No of Lecturers"; Rec."No of Lecturers")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approval Name"; Rec."Approval Name")
                {
                    ApplicationArea = All;
                }
                field("Approval Title"; Rec."Approval Title")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
                {
                    ApplicationArea = All;
                }
                field("Semester Range Descption"; Rec."Semester Range Descption")
                {
                    ApplicationArea = All;
                }
            }
            part("Loads List"; "Lect Load Batch Lines")
            {
                Caption = 'Loads List';
                SubPageLink = "Semester Code" = FIELD("Semester Code");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(CourseLoad)
            {
                Caption = 'Course Loading Summary';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    counted: Integer;
                    LectLoadBatchLines: Record "Lect Load Batch Lines";
                begin
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        //   REPORT.RUN(Report::"Lecturer Course Loading", TRUE, FALSE, LectLoadBatchLines);
                    END;
                end;
            }
            action(CourseLoadSum)
            {
                Caption = 'Course Loading Det,';
                Image = CalculateBinReplenishment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                // RunObject = Report 69274;
            }
            action("Load Missing Lectures")
            {
                Caption = 'Load Missing Lecturers';
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('This will load Missing Lecturers, Continue?', TRUE) = FALSE THEN ERROR('Cancelled by user:' + USERID);
                    HrEmployees.RESET;
                    HrEmployees.SETRANGE(HrEmployees.Lecturer, TRUE);
                    IF HrEmployees.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            LectLoadBatchLines.RESET;
                            LectLoadBatchLines.SETRANGE(LectLoadBatchLines."Semester Code", Rec."Semester Code");
                            LectLoadBatchLines.SETRANGE(LectLoadBatchLines."Lecturer Code", HrEmployees."No.");
                            IF NOT (LectLoadBatchLines.FIND('-')) THEN BEGIN
                                LectLoadBatchLines.INIT;
                                LectLoadBatchLines."Semester Code" := Rec."Semester Code";
                                LectLoadBatchLines."Lecturer Code" := HrEmployees."No.";
                                LectLoadBatchLines."Lecturer Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                                LectLoadBatchLines.VALIDATE("Lecturer Code");
                                LectLoadBatchLines.INSERT;
                            END ELSE BEGIN

                                LectLoadBatchLines."Lecturer Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                                LectLoadBatchLines.VALIDATE("Lecturer Code");
                                LectLoadBatchLines.MODIFY;
                            END;
                        END;
                        UNTIL HrEmployees.NEXT = 0;
                    END;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        LectLoadBatchLines: Record "Lect Load Batch Lines";
        LectLoadBatches1: Record "Lect Load Batches";
        lineNo: Integer;
        DateFilter: Date;

        HrEmployees: Record "HRM-Employee C";

        semedit: Boolean;

    trigger OnOpenPage()
    begin
        EnableEdit();
    end;

    procedure EnableEdit()
    begin
        semedit := false;
        if Rec."Semester Code" = '' then
            semedit := true;
    end;
}

