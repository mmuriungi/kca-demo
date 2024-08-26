codeunit 50077 "Doc. Mgnt. Ext."
{


    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        MaintenanceRequest: Record "Maintenance Request";
        UtilityBill: Record "Utility Bill";
    begin
        case DocumentAttachment."Table ID" of

            DATABASE::"Maintenance Request":
                begin
                    RecRef.Open(DATABASE::"Maintenance Request");
                    if MaintenanceRequest.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(MaintenanceRequest);
                end;
            DATABASE::"Utility Bill":
                begin
                    RecRef.Open(DATABASE::"Utility Bill");
                    if UtilityBill.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(UtilityBill);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of

            DATABASE::"Maintenance Request":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            DATABASE::"Utility Bill":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of

            DATABASE::"Maintenance Request":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"Utility Bill":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

}
