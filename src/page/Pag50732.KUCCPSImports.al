page 50732 "KUCCPS Imports"
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
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                }
                field(ser; Rec.ser)
                {
                    ApplicationArea = Basic;
                }
                field(Index; Rec.Index)
                {
                    ApplicationArea = Basic;
                }
                field(Admin; Rec.Admin)
                {
                    ApplicationArea = Basic;
                }
                field(Prog; Rec.Prog)
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = Basic;
                }
                field("Alt. Phone"; Rec."Alt. Phone")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = Basic;
                }
                field(Box; Rec.Box)
                {
                    ApplicationArea = Basic;
                }
                field(Codes; Rec.Codes)
                {
                    ApplicationArea = Basic;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("Alt Mail"; Rec."Slt Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Email Notification Send"; Rec."Email Notification Send")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field(OTP; Rec.OTP)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Documents Count"; Rec."Documents Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned Room"; Rec."Assigned Room")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned Space"; Rec."Assigned Space")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned Block"; Rec."Assigned Block")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Funding %"; Rec."Funding %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Billable_Amount; Rec.Billable_Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Funding Category"; Rec."Funding Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Approval Level"; Rec."Current Approval Level")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Process)
                {
                    ApplicationArea = Basic;
                    Caption = '&Process Admissions';
                    Image = ExecuteBatch;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ACAAdmImportedJABBuffer: Record "KUCCPS Imports";
                    begin
                        if Confirm('Process Selected Student?', true) = false then Error('Cancelled!');
                        // REPORT.RUN(REPORT::"Process JAB Admissions",TRUE,TRUE);
                        //  END ELSE BEGIN
                        ACAAdmImportedJABBuffer.Reset;
                        ACAAdmImportedJABBuffer.SetRange(ACAAdmImportedJABBuffer.Selected, true);
                        ACAAdmImportedJABBuffer.SetRange(ACAAdmImportedJABBuffer.Processed, false);
                        if ACAAdmImportedJABBuffer.Find('-') then begin
                            Report.Run(REPORT::"Process JAB Admissions", false, false, ACAAdmImportedJABBuffer);
                        end;
                        CurrPage.Update;
                    end;
                }
                action(Import)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Image = Import;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Import KUCCPS Students', true) = false then exit;
                        if Confirm('Arrange your CSV in the forllowing order:\' +
                        'ser' +
                        '\Index' +
                        '\Admin' +
                        '\Prog' +
                        '\Names' +
                        '\Gender' +
                        '\Phone' +
                        '\Alt. Phone' +
                        '\Box' +
                        '\Codes' +
                        '\Town' +
                        '\Email' +
                        '\Slt Mail') = false then;
                        Xmlport.Run(XmlPort::"Import KUCCPS Students", false, true);
                    end;
                }
                action(SelectAll)
                {
                    ApplicationArea = Basic;
                    Caption = 'Select All';
                    Image = SelectReport;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Clear(KUCCPSImports);
                        if not (Confirm('Select all records?', true)) then Error('Cancelled!');
                        KUCCPSImports.Reset;
                        KUCCPSImports.CopyFilters(Rec);
                        if KUCCPSImports.Find('-') then begin
                            repeat
                            begin
                                KUCCPSImports.Selected := true;
                                KUCCPSImports.Modify;
                            end;
                            until KUCCPSImports.Next = 0;
                        end;
                    end;
                }
                action(UnselectAll)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unselect All';
                    Image = UndoShipment;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not (Confirm('Unselect all records?', true)) then Error('Cancelled!');
                        KUCCPSImports.Reset;
                        KUCCPSImports.CopyFilters(Rec);
                        if KUCCPSImports.Find('-') then begin
                            repeat
                            begin
                                KUCCPSImports.Selected := false;
                                KUCCPSImports.Modify;
                            end;
                            until KUCCPSImports.Next = 0;
                        end;
                    end;
                }
                action(Archive)
                {
                    ApplicationArea = Basic;
                    Caption = 'Archive Selected';
                    Image = Archive;
                    Promoted = true;
                    PromotedIsBig = true;
                }
                action(SendNotifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Mail Notifications';
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SendMailNoticiations: Codeunit "Send Mails Easy";
                        KUCCPSImports: Record "KUCCPS Imports";
                    begin
                        if Confirm('Send email notification to Prospective Students?', true) = false then Error('Mail sending cancelled');
                        Clear(KUCCPSImports);
                        KUCCPSImports.Reset;
                        KUCCPSImports.SetRange(KUCCPSImports.Processed, false);
                        KUCCPSImports.SetRange(KUCCPSImports."Email Notification Send", false);
                        KUCCPSImports.SetFilter(KUCCPSImports.Email, '<>%1', '');
                        if KUCCPSImports.Find('-') then begin
                            repeat
                            begin
                                SendMailNoticiations.SendEmailEasy('Dear, ', KUCCPSImports.Names, 'We are glad to inform you that you have been offered admission to Karatina University.',
                                'You are therefore advised to start your Admission by filling your details on the Portal at <a href = "https://karu.ac.ke/kuccps-admission-2023-2024-updated/">Self Admission</a> to update your profile ' +
                                ' and do self admission', 'Disclaimer....', 'Disclaimer.....',
                                KUCCPSImports.Email, 'ADMISSION NOTIFICATION');
                                KUCCPSImports."Email Notification Send" := true;
                                KUCCPSImports.Modify;
                            end;
                            until KUCCPSImports.Next = 0;
                            Message('Notifications have been send.');
                        end else
                            Error('Nothing to update ');
                    end;
                }
            }
        }
    }

    var
        JAB: Record "KUCCPS Imports";
        Admissions: Record "ACA-Adm. Form Header";
        AdminSetup: Record "ACA-Adm. Number Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AdminCode: Code[20];
        KUCCPSImports: Record "KUCCPS Imports";


    procedure SplitNames(var Names: Text[100]; var Surname: Text[50]; var "Other Names": Text[50])
    var
        lngPos: Integer;
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ' ');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            "Other Names" := CopyStr(Names, lngPos + 1);
        end;

    end;
}

