page 51811 "KUCCPS Imports"
{
    PageType = List;
    //InsertAllowed = false;
    SourceTable = "KUCCPS Imports";
    SourceTableView = WHERE(Processed = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ser; Rec.ser)
                {
                    ApplicationArea = All;
                }
                field(Index; Rec.Index)
                {
                    ApplicationArea = All;
                }
                field(Admin; Rec.Admin)
                {
                    Caption = 'Admission No.';
                    ApplicationArea = All;
                }
                field(Reported; Rec.Reported)
                {
                    ApplicationArea = All;
                }
                field("Resent E-mail"; Rec."Resent E-mail")
                {
                    ApplicationArea = All;
                }
                field(Prog; Rec.Prog)
                {
                    Caption = 'Programme Code';
                    ApplicationArea = All;
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ApplicationArea = All;
                }
                
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field(FirstName; Rec.FirstName)
                {
                    Caption = 'First Name';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Other Name"; Rec."Other Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field("Alt. Phone"; Rec."Alt. Phone")
                {
                    ApplicationArea = All;
                }
                field(Box; Rec.Box)
                {
                    ApplicationArea = All;
                }
                field(Codes; Rec.Codes)
                {
                    ApplicationArea = All;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Slt Mail"; Rec."Slt Mail")
                {
                    ApplicationArea = All;
                }
                field("Campus Location"; Rec."Campus Location")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field("KUCCPS Batch"; Rec."KUCCPS Batch")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {


            action(ProcessAdmissions)
            {
                Caption = '&Process Admissions';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = process;
                ApplicationArea = All;
                //Visible

                trigger OnAction()
                var
                    ACAAdmImportedJABBuffer: Record "KUCCPS Imports";
                begin
                    IF CONFIRM('Process Selected Student?', TRUE) = FALSE THEN BEGIN
                        REPORT.RUN(Report::"Process JAB Admissions", TRUE, TRUE);
                    END ELSE BEGIN
                        ACAAdmImportedJABBuffer.RESET;
                        ACAAdmImportedJABBuffer.SETRANGE(ser, Rec.ser);
                        IF ACAAdmImportedJABBuffer.FIND('-') THEN BEGIN
                            REPORT.RUN(Report::"Process JAB Admissions", FALSE, FALSE, ACAAdmImportedJABBuffer);
                        END;
                    END;
                    CurrPage.UPDATE;
                end;
            }
            action(Import)
            {
                Caption = 'Import KUCCPS Students';
                Image = Import;
                Promoted = true;
                PromotedCategory = process;

                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Import KUCCPS Students', TRUE) = FALSE THEN EXIT;
                    XMLPORT.RUN(xmlport::"Import KUCCPS Students", FALSE, TRUE);
                end;
            }
            action(Print)
            {
                Caption = 'Print Admission Letter';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;

                trigger OnAction()
                begin
                    KUCCPSImports.RESET;
                    KUCCPSImports.SETFILTER(KUCCPSImports.Index, Rec.Index);
                    REPORT.RUN(Report::"Official Admission LetterJAb", TRUE, TRUE, KUCCPSImports);
                end;
            }
            action(update)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                trigger OnAction()
                begin
                    updateKuccps();
                end;
            }
            action(MarkReported)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                trigger OnAction()
                begin
                    notReported();
                end;
            }

        }
    }

    var

        KUCCPSImports: Record "KUCCPS Imports";
        admit: Record "ACA-Applic. Form Header";


    /// <summary>
    /// SplitNames.
    /// </summary>
    /// <param name="Names">VAR Text[100].</param>
    /// <param name="Surname">VAR Text[50].</param>
    /// <param name="Other Names">VAR Text[50].</param>
    procedure SplitNames(var Names: Text[100]; var Surname: Text[50]; var "Other Names": Text[50])
    var
        lngPos: Integer;
    begin
        /*Get the position of the space character*/
        lngPos := STRPOS(Names, ' ');
        IF lngPos <> 0 THEN BEGIN
            Surname := COPYSTR(Names, 1, lngPos - 1);
            "Other Names" := COPYSTR(Names, lngPos + 1);
        END;

    end;

    procedure updateKuccps()
    begin
        KUCCPSImports.Reset();
        KUCCPSImports.SetRange("Campus Location", 'MAIN');
        IF KUCCPSImports.Find('-') then begin
            repeat
                KUCCPSImports."KUCCPS Batch" := '2022/2023';
                KUCCPSImports.Modify();
            until KUCCPSImports.Next() = 0;
        end;
    end;

    procedure notReported()
    begin
        admit.Reset();
        admit.SetRange(Status, admit.Status::Admitted);
        if admit.Find('-') then begin
            repeat
                KUCCPSImports.Reset();
                KUCCPSImports.SetRange(Admin, admit."Admission No");
                if KUCCPSImports.Find('-') then begin
                    KUCCPSImports.Reported := True;
                    KUCCPSImports.Modify();
                end;
            until admit.Next() = 0
        end;
    end;
}

