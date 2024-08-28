page 51034 "Std Charge Reversal Card"
{
    Caption = 'Std Charge Reversal Card';
    PageType = Card;
    SourceTable = "Std-Charges Reversal Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            part(ChargeReversalLine; "Std-Charge  Reversal Line")
            {
                SubPageLink = "Document No." = FIELD("No.");


            }


        }


    }
    actions
    {
        area(Processing)
        {
            action(post)
            {
                ApplicationArea = All;
                ToolTip = 'Post the document';

                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Post';
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        if Confirm('Do you want to post ' + Format(Rec."No."), true) then begin


                            postToGL();
                            Rec.Status := Rec.Status::Posted;
                            Rec.Posted := true;
                            Rec.Modify(true);
                        end;

                    end;
                end;
            }
        }
    }
    var
        genline: record "Gen. Journal Line";
        lineNo: Integer;
        reversalLine: record "Std-Charger Reversal Lines";

    procedure postToGL()
    begin
        if Rec.Posted = false then begin
            Rec.CalcFields("Total Amount");
            GenLine.RESET;
            GenLine.SETRANGE(GenLine."Journal Template Name", 'GENERAL');
            GenLine.SETRANGE(GenLine."Journal Batch Name", 'DEFAULT');
            IF GenLine.FIND('+') THEN BEGIN

                GenLine.DELETEALL;
                begin

                    lineNo := lineNo + 110000;
                    rec.CalcFields("Total Amount");
                    genline.Init();
                    genline."Journal Template Name" := 'GENERAL';
                    genline."Journal Batch Name" := 'DEFAULT';
                    genline."Line No." := lineNo + 1;
                    genline."Document No." := Rec."No.";
                    genline."Posting Date" := Rec."Document Date";
                    genline."Account Type" := genline."Account Type"::Customer;
                    genline.Validate("Account Type");
                    genline."Account No." := rec."Student No";
                    genline.Description := Rec.Description;
                    genline.Amount := Rec."Total Amount" * -1;
                    genline.Validate(Amount);
                    if genline.Amount <> 0 then
                        genline.Insert()
                end;


            end;

            reversalLine.RESET;
            reversalLine.SETRANGE("Document No.", Rec."No.");
            IF reversalLine.FINDSET THEN BEGIN
                REPEAT
                begin
                    lineNo := lineNo + 10000;
                    genline.INIT;
                    genline."Line No." := lineNo;
                    genline."Document No." := Rec."No.";
                    genline."Posting Date" := Rec."Document Date";
                    genline."Journal Template Name" := 'GENERAL';
                    genline."Journal Batch Name" := 'DEFAULT';
                    genline."Account Type" := genline."Account Type"::"G/L Account";
                    genline."Account No." := reversalLine."Charge G/l Account";
                    genline."Description" := reversalLine."Charge Description";
                    genline."Amount" := reversalLine.amount;
                    genline.Validate(Amount);
                    if genline.Amount <> 0 then
                        genline.INSERT;



                end;
                UNTIL reversalLine.NEXT = 0;
            END;

        end;
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenLine);
    end;

}
