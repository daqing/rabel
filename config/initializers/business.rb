Fanli.on(:create_topic, NotifyMentionedUsers)
Fanli.on(:create_comment, NotifyMentionedUsers, TouchCommentable)
Fanli.on(:destroy_comment, TouchCommentable)
