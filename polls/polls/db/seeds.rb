User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

users = []

def respond_with(choice, user)
  Response.create!(responder_id: choice.id, answer_choice_id: user.id)
end

def ac_for(q, completing_user = nil)
  answer_choices = []
  (rand(5) + 3).times do |i|
    answer_choices << AnswerChoice.create!(choice:"choice_#{i}", question_id: q.id)
  end
  n = users.shuffle
  rand(5).times do |i|
    choice = answer_choices.sample
    respond_with(choice, n.pop)
  end
  if n.include?(completing_user)
    respond_with(answer_choices.sample, completing_user)
  end
end

def questions_for(p, completing_user = nil)
  5.times do |i|
    q = Question.create!(question:"Q_?_#{i}", poll_id: p.id)
    ac_for(q, completing_user)
  end
end

def polls_for(u)
  5.times do |i|
    p = Poll.create!(title: "title_#{i}", author_id: u.id)
    questions_for(p)
  end
  rand(5).times do |completed|
    p = Poll.create!(title: "title_#{completed}", author_id: u.id)
    questions_for(p, u)
  end
end

def generate
  10.times do |user_i|
    u = User.create!(user_name: "user_#{user_i}")
    users << u
  end
  users.shuffle!
  (0...10).times do |u|
    polls_for(users[u])
  end
end

generate

# user1 = User.create!(user_name: 'Anne')
# user2 = User.create!(user_name: 'Kevin')
#
# poll1 = Poll.create!(title: 'color', author_id: user1.id)
# poll2 = Poll.create!(title: 'food', author_id: user2.id)
#
# q1 = Question.create!(question: 'fave color', poll_id: poll1.id)
# q2 = Question.create!(question: 'hated color', poll_id: poll1.id)
# q3 = Question.create!(question: 'fave food', poll_id: poll2.id)
# q4 = Question.create!(question: 'cuisines', poll_id: poll2.id)
#
# a1 = AnswerChoice.create!(choice: 'a', question_id: q1.id)
# a2 = AnswerChoice.create!(choice: 'b', question_id: q1.id)
# a3 = AnswerChoice.create!(choice: 'c', question_id: q1.id)
# a4 = AnswerChoice.create!(choice: 'd', question_id: q1.id)
#
# a11 = AnswerChoice.create!(choice: 'a', question_id: q2.id)
# a12 = AnswerChoice.create!(choice: 'b', question_id: q2.id)
# a13 = AnswerChoice.create!(choice: 'a', question_id: q3.id)
# a14 = AnswerChoice.create!(choice: 'b', question_id: q3.id)
#
# a21 = AnswerChoice.create!(choice: 'a', question_id: q4.id)
# a22 = AnswerChoice.create!(choice: 'b', question_id: q4.id)
#
# r1 = Response.create!(responder_id: user2.id, answer_choice_id: a11.id)
# r2 = Response.create!(responder_id: user2.id, answer_choice_id: a1.id)
# r3 = Response.create!(responder_id: user2.id, answer_choice_id: a2.id)
# r4 = Response.create!(responder_id: user1.id, answer_choice_id: a14.id)
# r5 = Response.new(responder_id: user1.id, answer_choice_id: a13.id)
# puts r5.valid?
# r6 = Response.create!(responder_id: user1.id, answer_choice_id: a21.id)
