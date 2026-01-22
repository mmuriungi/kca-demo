page 50964 "TBL Exam Results Buff."
{
    ApplicationArea = All;
    Caption = 'Results Capture List';
    PageType = List;
    SourceTable = "TBL Exam Results Buff.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ToolTip = 'Specifies the value of the Semester Code field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Specifies the value of the Student Name field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Exam Score"; Rec."Exam Score")
                {
                    ToolTip = 'Specifies the value of the Exam Score field.';
                    ApplicationArea = All;
                }
                field("CAT Score"; Rec."CAT Score")
                {
                    ToolTip = 'Specifies the value of the CAT Score field.';
                    ApplicationArea = All;
                }
                field("Tota Score"; Rec."Total Score")
                {
                    ToolTip = 'Specifies the value of the Tota Score field.';
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = true;
                    Editable = false;
                    Enabled = false;
                }
                field("CAT Captured By"; Rec."CAT Captured By")
                {
                    ToolTip = 'Specifies the value of the CAT Captured By field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Exam Captured By"; Rec."Exam Captured By")
                {
                    ToolTip = 'Specifies the value of the Exam Captured By field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }

                field("Exam FLow"; Rec."Exam FLow")
                {
                    ToolTip = 'Specifies the value of the Exam FLow field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("CAT FLow"; Rec."CAT FLow")
                {
                    ToolTip = 'Specifies the value of the CAT FLow field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Overal Score Flow"; Rec."Overal Score Flow")
                {
                    ToolTip = 'Specifies the value of the Overal Score Flow field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Lecturer Posted Marks"; Rec."Lecturer Posted Marks")
                {
                    ToolTip = 'Specifies the value of the Lecturer Posted Marks field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ToolTip = 'Specifies the value of the Lecturer Code field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("User Code"; Rec."User Code")
                {
                    ToolTip = 'Specifies the value of the User Code field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ToolTip = 'Specifies the value of the Exam Category field.';
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                // field(deleterec; deleterec)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Delete the Line';
                //     Caption = '';
                //     Editable = false;
                //     trigger OnLookup(var Text: Text): Boolean;
                //     var
                //         myInt: Integer;
                //         examRes: record "ACA-Exam Results";

                //     begin
                //         if confirm('Delete Record?', false) = false then Error('Delete Cancelled!');

                //         examRes.Reset();
                //         examRes.SetRange(Programmes, Rec."Programme Code");
                //         examRes.SetRange(semester, Rec."Semester Code");
                //         examRes.SetRange(Unit, Rec."Unit Code");
                //         examRes.SetRange("Student No.", Rec."Student No.");
                //         if examRes.find('-') then examRes.DeleteAll(true);
                //         Message('Marks Deleted for ' + Rec."Student No." + 'Unit: ' + Rec."Unit Code");
                //     end;
                // }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Posts")
            {
                Image = PostedOrder;
                Caption = 'Post Marks';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ResBufferDet: Record "TBL Exam Results Buff.";
                    ExamRes: Record "ACA-Exam Results";
                    ExamResCAT: Record "ACA-Exam Results";
                    StudUnits: Record "ACA-Student Units";
                    ProgUnits: Record "ACA-Units/Subjects";
                    prog: Record "Aca-programme";
                    Semes: Record "ACA-Semesters";
                    emps: Record "HRM-Employee C";
                    Webportals: Codeunit webportals;
                    AcaCourseReg: record "ACA-Course Registration";
                begin
                    if confirm('Post Marks?', true) = false then Error('Cancelled by user!');
                    if Rec."Semester Code" = '' then Error('Specify Semester FIlter!');
                    if Rec."Unit Code" = '' then Error('Specify Unit FIlter!');
                    if Rec."Programme Code" = '' then Error('Specify Programme FIlter!');
                    if Rec."Lecturer Code" = '' then Error('Specify Lecturer FIlter!');
                    emps.Reset();
                    emps.SetRange("No.", Rec."Lecturer Code");
                    if emps.Find('-') then begin
                    end else
                        Error('Invalid Employee Number');
                    clear(prog);
                    prog.Reset();
                    prog.SetRange("Code", Rec.GetFilter("Programme Code"));
                    if prog.find('-') then;
                    ResBufferDet.Reset();
                    ResBufferDet.SetRange(ResBufferDet."Programme Code", Rec."Programme Code");
                    ResBufferDet.SetRange(ResBufferDet."Semester Code", Rec."Semester Code");
                    ResBufferDet.SetRange(ResBufferDet."Unit Code", Rec."Unit Code");
                    if ResBufferDet.Find('-') then begin
                        repeat
                        begin
                            if ((ResBufferDet."CAT Score" <> 0) OR (ResBufferDet."Exam Score" <> 0)) then begin
                                Clear(AcaCourseReg);
                                AcaCourseReg.Reset();
                                AcaCourseReg.SetRange(Semester, ResBufferDet."Semester Code");
                                AcaCourseReg.SetRange(Programmes, ResBufferDet."Programme Code");
                                AcaCourseReg.SetRange("Student No.", ResBufferDet."Student No.");
                                AcaCourseReg.SetRange(Reversed, false);
                                if AcaCourseReg.Find('-') then begin
                                    if ResBufferDet."Exam Score" > 0 then begin
                                        Clear(ExamRes);
                                        ExamRes.Reset();
                                        ExamRes.SetRange(Programmes, ResBufferDet."Programme Code");
                                        ExamRes.SetRange(semester, ResBufferDet."Semester Code");
                                        ExamRes.SetRange(Unit, ResBufferDet."Unit Code");
                                        examRes.SetRange("Student No.", ResBufferDet."Student No.");
                                        ExamRes.SetFilter(ExamType, '%1|%2|%3', 'EXAM', 'FINAL EXAM', 'FINAL');
                                        if not ExamRes.find('-') then begin
                                            //modification
                                            ExamRes.Init();
                                            ExamRes.Programmes := ResBufferDet."Programme Code";
                                            ExamRes.Stage := AcaCourseReg.Stage;
                                            ExamRes.Unit := ResBufferDet."Unit Code";
                                            ExamRes.Semester := ResBufferDet."Semester Code";
                                            ExamRes."Student No." := ResBufferDet."Student No.";
                                            ExamRes.Category := prog."Exam Category";
                                            ExamRes."Exam Category" := prog."Exam Category";
                                            ExamRes."Reg. Transaction ID" := AcaCourseReg."Reg. Transacton ID";
                                            ExamRes.Validate(Score, ResBufferDet."Exam Score");
                                            ExamRes.ExamType := 'FINAL EXAM';
                                            ExamRes.Exam := 'FINAL EXAM';
                                            ExamRes."Admission No" := ResBufferDet."Student No.";
                                            ExamRes."User Code" := UserId;
                                            ExamRes.Submitted := true;
                                            ExamRes."Submitted By" := UserId;
                                            ExamRes."Submitted On" := Today;
                                            ExamRes.Insert(true);
                                            ResBufferDet.Posted := true;
                                            ResBufferDet.Modify(true)
                                        end
                                        else
                                            if ExamRes.find('-') then begin
                                                ExamRes.Validate(Score, ResBufferDet."Exam Score");
                                                if ExamRes.Modify(true) then;
                                                ResBufferDet.Posted := true;
                                                ResBufferDet.Modify(true)
                                            end;
                                    end;

                                    ///////////////////////////////////////////////////////////
                                    ///   
                                    if ResBufferDet."CAT Score" > 0 then begin
                                        Clear(ExamResCAT);
                                        ExamResCAT.Reset();
                                        ExamResCAT.SetRange(Programmes, ResBufferDet."Programme Code");
                                        ExamResCAT.SetRange(semester, ResBufferDet."Semester Code");
                                        ExamResCAT.SetRange(Unit, ResBufferDet."Unit Code");
                                        ExamResCAT.SetRange("Student No.", ResBufferDet."Student No.");
                                        ExamResCAT.SetFilter(ExamType, '%1|%2|%3|%4', 'CAT', 'CATS', 'CAT 1', 'CAT 2');
                                        if not ExamResCAT.find('-') then begin
                                            ExamResCAT.Init();
                                            ExamResCAT.Programmes := ResBufferDet."Programme Code";
                                            ExamResCAT.Stage := AcaCourseReg.Stage;
                                            ExamResCAT.Unit := ResBufferDet."Unit Code";
                                            ExamResCAT.Semester := ResBufferDet."Semester Code";
                                            ExamResCAT."Student No." := ResBufferDet."Student No.";
                                            ExamResCAT.Category := prog."Exam Category";
                                            ExamResCAT."Exam Category" := prog."Exam Category";
                                            ExamResCAT."Reg. Transaction ID" := AcaCourseReg."Reg. Transacton ID";
                                            ExamResCAT.Validate(Score, ResBufferDet."CAT Score");
                                            ExamResCAT.ExamType := 'CAT';
                                            ExamResCAT.Exam := 'CAT';
                                            ExamResCAT."Admission No" := ResBufferDet."Student No.";
                                            ExamResCAT."User Code" := UserId;
                                            ExamResCAT.Submitted := true;
                                            ExamResCAT."Submitted By" := UserId;
                                            ExamResCAT."Submitted On" := Today;
                                            IF ExamResCAT.Insert(true) then;
                                            Rec.Posted := true;
                                            Rec.Modify(true)
                                        end else
                                            if ExamResCAT.find('-') then begin
                                                ExamResCAT.Validate(Score, ResBufferDet."CAT Score");
                                                if ExamResCAT.Modify(true) then;
                                                Rec.Posted := true;
                                                Rec.Modify(true)
                                            end;
                                    end;
                                end;
                                ///////////////////////////////////////////////////////////
                            end;
                        end;
                        until ResBufferDet.Next() = 0;
                    end;
                end;
            }
            action(IndMarksheet)

            {
                ApplicationArea = All;
                Caption = 'Individual Marksheet', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ViewComments;
                trigger OnAction()
                var
                    ResultsBuffTbL: Record "TBL Exam Results Buff.";
                begin
                    Clear(ResultsBuffTbL);
                    ResultsBuffTbL.CopyFilters(Rec);
                    if ResultsBuffTbL.find('-') then
                        report.Run(Report::"Individual Marksheet", true, false, ResultsBuffTbL);
                end;
            }
            action(DeleteScore)
            {
                ApplicationArea = All;
                Caption = 'Delete Mark', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DeleteAllBreakpoints;

                trigger OnAction()
                var
                    ExamRes: Record "ACA-Exam Results";
                begin
                    if Confirm('Delete Score?', false) = false then Error('Deletion cancelled by user!');

                    clear(ExamRes);
                    ExamRes.Reset();
                    ExamRes.SetRange(Programmes, Rec."Programme Code");
                    ExamRes.SetRange(semester, Rec."Semester Code");
                    ExamRes.SetRange(Unit, Rec."Unit Code");
                    examRes.SetRange("Student No.", Rec."Student No.");
                    examRes.SetRange("User Code", UserId);
                    if examRes.Find('-') then examRes.DeleteAll(true);
                    Rec.Delete(true);

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        deleterec := 'Delete';

    end;

    var
        deleterec: Text[20];
}
