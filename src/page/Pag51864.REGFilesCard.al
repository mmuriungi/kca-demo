page 51864 "REG-Files Card"
{
    Caption = 'REG-Files Card';
    PageType = Card;
    SourceTable = "REG-Files";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    // Editable = editOpen;
                    ToolTip = 'Specifies the value of the File No. field.';
                    ApplicationArea = All;
                }
                field("Section Number"; Rec."Section Number")
                {
                    Editable = snumber;
                    ToolTip = 'Specifies the value of the Section Number field.';
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Section Name field.';
                    ApplicationArea = All;
                }
                field(Abbreviation; Rec.Abbreviation)
                {
                    //Editable = false;
                    ToolTip = 'Specifies the value of the Abbreviation field.';
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = editfname;
                    ToolTip = 'Specifies the value of the File Name field.';
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("File Index"; Rec."File Index")
                {
                    //Editable = false;
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Folios)
            {
                part(Part; "REG-DocAttachmentsLstpart")
                {
                    SubPageLink = "No." = field("File Index");
                    ApplicationArea = All;
                }
            }
            group(Movement)
            {
                part(Lines; "REG-File Movement List")
                {
                    ApplicationArea = All;
                    SubPageLink = "File Index" = field("File Index");
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Attach Folio';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                RunObject = Page "REG-Doc Attach Details";

                RunPageLink = "No." = field("File Index"), Closed = const(false), Archived = const(false);
            }
            action("File Movement")
            {
                ApplicationArea = All;
                Caption = 'File Movement';
                Image = FileContract;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    fmove: Record "REG-File Movement";
                begin
                    Rec.TestField("File Name");
                    if Rec.Closed = false then begin
                        fmove.Reset();
                        fmove.SetRange("File Index", Rec."File Index");
                        fmove.SetRange("Folio Returned", false);
                        if fmove.Find('-') then
                            Error('The Document is in circulation');
                        fmove.Init();
                        fmove."No." := Rec.GetLastEntryNo() + 1;
                        fmove."File Index" := Rec."File Index";
                        fmove."Cabinet Number" := Rec."Section Number";
                        fmove."Date Sent" := Today;
                        fmove."Cabinet Name" := Rec."Section Name";
                        fmove.Insert();
                        page.Run(Page::"REG-File Movement", fmove);
                    end;

                end;

            }

            action("Close File")
            {
                ApplicationArea = All;
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Closed files will be visible on Archive Registry';

                trigger OnAction()
                var
                    DocAttach: Record "REG-Doc Attachment";
                    ArchReg: Record "REG-Archives Register";
                    Counter: Integer;
                begin
                    IF NOT DIALOG.CONFIRM('You are about to close this file, continue?', TRUE) THEN
                        Error('Cancelled');
                    //copy from rec to archives register
                    ArchReg.Reset;
                    Rec.TestField(Period);
                    Rec.SetRange("File Index", Rec."File Index");
                    //Rec.SetFilter(Version, '<>%1', Rec.Version);
                    //Rec.SetRange("No.", Rec."No.");
                    if Rec.Find('-') then begin
                        ArchReg."File Index" := Rec."File Index";
                        ArchReg.Closed := true;
                        ArchReg.Period := Rec.Period;
                        ArchReg."Closed By" := UserId;
                        ArchReg."Closed Date" := CurrentDateTime;
                        ArchReg.Insert;
                        DocAttach.setfilter(DocAttach."No.", '=%1', Rec."File Index");
                        if DocAttach.FindSet() then
                            repeat
                                DocAttach.Closed := true;
                                DocAttach.Modify;
                                Counter += 1;
                            until DocAttach.Next = 0;
                        //Closed file message
                        Message('File No:%1 closed with %2 Folios', Rec."File Index", Counter);
                    end;
                end;
            }

            action("Update Index")
            {
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    No: Integer;
                    fileNo: Text[30];
                    fileName: Text[150];
                    fileIndex: Code[50];
                begin
                    Rec.updateRec();
                end;

            }

            //what happens when you close/archive? to create Logic
            //onclose copy to new version
            //on archive delete entry and copy to archives table
        }
    }

    var
        editOpen: Boolean;
        editfname: Boolean;
        snumber: Boolean;

    trigger OnOpenPage()
    begin
        Editability();
    end;

    procedure Editability()
    begin
        editOpen := false;
        editfname := false;
        snumber := false;
        if Rec."File No." = '' then
            editOpen := true;
        if Rec."File Name" = '' then
            editfname := true;
        if Rec."Section Name" = '' then
            snumber := true;

    end;


}
