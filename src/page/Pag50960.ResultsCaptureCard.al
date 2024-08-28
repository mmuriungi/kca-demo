page 50960 "Results Capture Card"
{
    Caption = 'Results Capture Card';
    PageType = Card;
    SourceTable = "Results Capture Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ToolTip = 'Specifies the value of the Semester Code field.';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.';
                    ApplicationArea = All;
                }
                field("Program Name"; Rec."Program Name")
                {
                    ToolTip = 'Specifies the value of the Program Name field.';
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.';
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ToolTip = 'Specifies the value of the Unit Name field.';
                    ApplicationArea = All;
                }
                field("Lecturer User ID"; Rec."Lecturer User ID")
                {
                    ToolTip = 'Specifies the value of the Lecturer User ID field.';
                    ApplicationArea = All;
                }
                field("Lecturer PF No."; Rec."Lecturer PF No.")
                {
                    ToolTip = 'Specifies the value of the Lecturer PF No. field.';
                    ApplicationArea = All;
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    ToolTip = 'Specifies the value of the Lecturer Name field.';
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
            }

        }
    }

    actions
    {
        area(creation)
        {
            action("Submit")
            {
                Image = PostedDeposit;
                Caption = 'Submit Filters';
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ResBufferDet: Record "TBL Exam Results Buff.";
                    ExamRes: Record "ACA-Exam Results";
                    ExamResCAT: Record "ACA-Exam Results";
                    StudUnits: Record "ACA-Student Units";
                    Semes: Record "ACA-Semesters";
                    emps: Record "HRM-Employee C";
                begin
                    if confirm('Submit Filters?', true) = false then Error('Cancelled by user!');
                    if Rec."Programme Code" = '' then Error('Specify Programme FIlter!');
                    if Rec."Semester Code" = '' then Error('Specify Semester FIlter!');
                    if Rec."Unit Code" = '' then Error('Specify Unit FIlter!');
                    if Rec."Programme Code" = '' then Error('Specify Programme FIlter!');
                    if Rec."Lecturer PF No." = '' then Error('Specify Lecturer FIlter!');
                    emps.Reset();
                    emps.SetRange("No.", Rec."Lecturer PF No.");
                    if emps.Find('-') then begin
                        if emps."Portal Password" = '' then Error('Access Denied');
                        if emps."Portal Password" <> Rec.Password then Error('Access Denied');
                    end else
                        Error('Invalid Employee Number');
                    Semes.Reset();
                    Semes.SetRange("code", Rec."Semester Code");
                    if Semes.Find('-') then
                        Semes.TestField("Academic Year")
                    else
                        Error('Missing Academic Year on Semester definition');

                    StudUnits.Reset();
                    StudUnits.SetRange(Programme, Rec."Programme Code");
                    StudUnits.SetRange(semester, Rec."Semester Code");
                    StudUnits.SetRange(Unit, Rec."Unit Code");
                    StudUnits.SetRange("Reg. Reversed", false);
                    if StudUnits.find('-') then begin
                        repeat
                        begin
                            clear(ExamRes);
                            ExamRes.Reset();
                            ExamRes.SetRange(Programmes, Rec."Programme Code");
                            ExamRes.SetRange(semester, Rec."Semester Code");
                            ExamRes.SetRange(Unit, Rec."Unit Code");
                            examRes.SetRange("Student No.", StudUnits."Student No.");
                            ExamRes.SetFilter(ExamType, '%1|%2|%3', 'EXAM', 'FINAL EXAM', 'FINAL');
                            if ExamRes.find('-') then;
                            clear(ExamResCAT);
                            ExamResCAT.Reset();
                            ExamResCAT.SetRange(Programmes, Rec."Programme Code");
                            ExamResCAT.SetRange(semester, Rec."Semester Code");
                            ExamResCAT.SetRange(Unit, Rec."Unit Code");
                            ExamResCAT.SetRange("Student No.", StudUnits."Student No.");
                            ExamResCAT.SetFilter(ExamType, '%1|%2|%3|%4', 'CAT', 'CATS', 'CAT 1', 'CAT 2');
                            if ExamResCAT.find('-') then;
                            ResBufferDet.Init();
                            ResBufferDet."Academic Year" := Rec."Academic Year";
                            ResBufferDet."Semester Code" := Rec."Semester Code";
                            ResBufferDet."Lecturer Code" := rec."Lecturer PF No.";
                            ResBufferDet."Student No." := StudUnits."Student No.";
                            ResBufferDet."Programme Code" := StudUnits.Programme;
                            ResBufferDet."Unit Code" := StudUnits.Unit;
                            if ExamResCAT.Score <> 0 then begin
                                ResBufferDet."CAT Score" := ExamResCAT.Score;
                                ResBufferDet."CAT Captured By" := ExamResCAT."User Code";
                            end;
                            if ExamRes.Score <> 0 then begin
                                ResBufferDet."Exam Score" := ExamRes.Score;
                                ResBufferDet."Exam Captured By" := ExamRes."User Code";
                            end;
                            if ResBufferDet.Insert(true) then;
                            clear(ResBufferDet);
                            ResBufferDet.Reset();
                            ResBufferDet.SetRange(ResBufferDet."Programme Code", Rec."Programme Code");
                            ResBufferDet.SetRange(ResBufferDet."Semester Code", Rec."Semester Code");
                            ResBufferDet.SetRange(ResBufferDet."Unit Code", Rec."Unit Code");
                            ResBufferDet.SetRange(ResBufferDet."Student No.", StudUnits."Student No.");
                            if ResBufferDet.Find('-') then begin
                                if ResBufferDet."CAT Score" = 0 then
                                    if ExamResCAT.Score <> 0 then begin
                                        ResBufferDet."CAT Score" := ExamResCAT.Score;
                                        ResBufferDet."CAT Captured By" := ExamResCAT."User Code";
                                    end;
                                if ResBufferDet."Exam Score" = 0 then
                                    if ExamRes.Score <> 0 then begin
                                        ResBufferDet."Exam Score" := ExamRes.Score;
                                        ResBufferDet."Exam Captured By" := ExamRes."User Code";
                                    end;
                                if ResBufferDet.Modify(true) then;
                            end;
                        end;
                        until StudUnits.Next() = 0;
                    end;
                    clear(ResBufferDet);
                    ResBufferDet.Reset();
                    ResBufferDet.SetRange(ResBufferDet."Programme Code", Rec."Programme Code");
                    ResBufferDet.SetRange(ResBufferDet."Semester Code", Rec."Semester Code");
                    ResBufferDet.SetRange(ResBufferDet."Unit Code", Rec."Unit Code");
                    if ResBufferDet.Find('-') then begin
                        page.Run(Page::"TBL Exam Results Buff.", ResBufferDet);
                    end else
                        Error('No students Registered in ' + Rec."Programme Code" + ' ' + Rec."Unit Code" + ' ' + Rec."Semester Code");

                end;
            }
            // action("Print Marksheet")
            // {
            //     Image = ApplicationWorksheet;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     RunObject = Page "Graduation Units List";
            //     RunPageLink = "Student No." = FIELD("Student Number"),
            //                   Programme = FIELD(Programme),
            //                   "Graduation Academic Year" = FIELD("Graduation Academic Year");
            //     ApplicationArea = All;
            // }
            // action("Not Graduating Reasons")
            // {
            //     Image = DocInBrowser;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     RunObject = Page "Graduation Failure Reasons";
            //     RunPageLink = "Student No." = FIELD("Student Number"),
            //                   "Graduation Academic Year" = FIELD("Graduation Academic Year");
            //     ApplicationArea = All;
            // }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    //  emplC: record hrm
    begin

    end;

}
