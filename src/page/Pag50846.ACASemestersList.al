page 50846 "ACA-Semesters List"
{
    PageType = List;

    SourceTable = "ACA-Semesters";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Current Semester"; Rec."Current Semester")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("SMS Results Semester"; Rec."SMS Results Semester")
                {
                    ApplicationArea = All;
                }
                field("Lock Exam Editting"; Rec."Lock Exam Editting")
                {
                    ApplicationArea = All;
                }
                field("Lock CAT Editting"; Rec."Lock CAT Editting")
                {
                    ApplicationArea = All;
                }
                field("Ignore Editing Rule"; Rec."Ignore Editing Rule")
                {
                    ApplicationArea = All;
                }
                field("Released Results"; Rec."Released Results")
                {
                    ApplicationArea = All;
                }
                field("Marks Changeable"; Rec."Marks Changeable")
                {
                    ApplicationArea = All;
                }
                field("Evaluate Lecture"; Rec."Evaluate Lecture")
                {
                    ApplicationArea = All;
                }
                field("Exam Start Date"; Rec."Exam Start Date")
                {
                    ApplicationArea = All;
                }
                field("Exam End Date"; Rec."Exam End Date")
                {
                    ApplicationArea = All;
                }
                field("Supp Start Date"; Rec."Supp Start Date")
                {
                    ApplicationArea = All;
                }
                field("Supp End Date"; Rec."Supp End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Card)
            {
#pragma warning disable AL0482
                Image = card;
#pragma warning restore AL0482
                RunObject = Page "ACA-Semester Card";
                RunPageLink = Code = FIELD(Code);
                ApplicationArea = All;
            }
        }
        area(Processing)
        {
            action("ACA-Prog/Stage Sem. Schedule")
            {
                ApplicationArea = All;
                Caption = 'ACA-Prog/Stage Sem. Schedule';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Line;
                RunObject = Page "ACA-Prog/Stage Sem. Schedule";
                RunPageLink = Code = FIELD(Code);
            }
            action(TEstMArks)
            {
                ApplicationArea = All;
                Caption = 'TEst MArks';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Line;
                trigger OnAction()
                var
                    myInt: codeunit webportals;
                begin
                    myInt.Run();
                end;
            }
        }
    }
}

