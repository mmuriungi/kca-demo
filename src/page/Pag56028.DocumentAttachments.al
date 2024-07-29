page 56028 "Document Attachments"
{
    PageType = List;
    SourceTable = "Document Attachments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Attachments)
            {
                Caption = 'Attachments';
                action(Open)
                {
                    Caption = 'Open';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF DocLink.GET(Rec."Document No", Rec."Document Description") THEN BEGIN
                            IF InteractTemplLanguage.GET(DocLink."Document No", DocLink."Language Code (Default)", DocLink."Document Description") THEN
                                InteractTemplLanguage.OpenAttachment;
                        END;
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = CreateForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF DocLink.GET(Rec."Document No", Rec."Document Description") THEN BEGIN
                            IF NOT InteractTemplLanguage.GET(DocLink."Document No", DocLink."Language Code (Default)", DocLink."Document Description") THEN BEGIN
                                InteractTemplLanguage.INIT;
                                InteractTemplLanguage."Interaction Template Code" := Rec."Document No";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := Rec."Document Description";
                            END;
                            InteractTemplLanguage.CreateAttachment;
                            CurrPage.UPDATE;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.MODIFY;
                        END;
                    end;
                }
                action("Copy & From")
                {
                    Caption = 'Copy & From';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF DocLink.GET(Rec."Document No", Rec."Document Description") THEN BEGIN

                            IF InteractTemplLanguage.GET(DocLink."Document No", DocLink."Language Code (Default)", DocLink."Document Description") THEN
                                InteractTemplLanguage.CopyFromAttachment;
                            CurrPage.UPDATE;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.MODIFY;
                        END;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF DocLink.GET(Rec."Document No", Rec."Document Description") THEN BEGIN
                            IF NOT InteractTemplLanguage.GET(DocLink."Document No", DocLink."Language Code (Default)", DocLink."Document Description") THEN BEGIN
                                InteractTemplLanguage.INIT;
                                InteractTemplLanguage."Interaction Template Code" := Rec."Document No";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := DocLink."Document Description";
                                InteractTemplLanguage.INSERT;
                            END;
                            InteractTemplLanguage.ImportAttachment;
                            CurrPage.UPDATE;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.MODIFY;
                        END;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF DocLink.GET(Rec."Document No", Rec."Document Description") THEN BEGIN
                            IF InteractTemplLanguage.GET(DocLink."Document No", DocLink."Language Code (Default)", DocLink."Document Description") THEN
                                InteractTemplLanguage.ExportAttachment;
                        END;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        IF DocLink.GET(Rec."Document No", Rec."Document Description") THEN BEGIN
                            IF InteractTemplLanguage.GET(DocLink."Document No", DocLink."Language Code (Default)", DocLink."Document Description") THEN BEGIN
                                InteractTemplLanguage.RemoveAttachment(TRUE);
                                DocLink.Attachment := DocLink.Attachment::No;
                                DocLink.MODIFY;
                            END;
                        END;
                    end;
                }
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record "Document Attachments";

    procedure GetDocument() Document: Text[200]
    begin
        Document := Rec."Document Description";
    end;
}

