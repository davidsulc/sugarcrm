require 'helper'

class TestSetNoteAttachment < Test::Unit::TestCase
  context "A SugarCRM.connection" do
    should "Add an attachment to a Note" do
      SugarCRM.connect(URL, USER, PASS, {:debug => false})
      n = SugarCRM::Note.new
      n.name = "A Test Note"
      assert n.save
      file = File.read("test/config_test.yaml")
      assert SugarCRM.connection.set_note_attachment(n.id, "config_test.yaml", file)
      attachment = SugarCRM.connection.get_note_attachment(n.id)
      assert Base64.decode64(attachment["file"]) == file
      assert n.delete
    end
  end
end