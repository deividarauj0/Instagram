require 'rails_helper'

RSpec.describe Post, type: :model do
    context "Validações" do
      it "exige uma descrição" do
        post = Post.new(description: nil)
        expect(post).to_not be_valid
        expect(post.errors[:description]).to be_present
      end
  
      it "exige que a foto esteja anexada" do
        post = Post.new(description: "Primeiro post")
        expect(post).to_not be_valid
        expect(post.errors[:photo]).to be_present
      end
  
      it "permite salvar um post válido" do
        user = User.create(name: "John")
        post = Post.new(description: "Primeiro post", created_by_id: user.id, created_by: user)
        file = fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg'), 'image/jpeg')
        post.photo.attach(file)
        expect(post).to be_valid
        expect(post.save).to be_truthy
      end          
    end
  
    context "Relacionamentos" do
      it "pertence a um usuário criador" do
        user = User.create(name: "John")
        post = Post.new(description: "Primeiro post", created_by: user)
        expect(post.created_by).to eq(user)
      end
  
      it "tem muitos likes" do
        post = Post.new(description: "Primeiro post")
        like1 = post.likes.new(user: User.new)
        like2 = post.likes.new(user: User.new)
        expect(post.likes).to include(like1, like2)
      end
  
      it "tem muitos comentários" do
        post = Post.new(description: "Primeiro post")
        comment1 = post.comments.new(body: "Comentário 1")
        comment2 = post.comments.new(body: "Comentário 2")
        expect(post.comments).to include(comment1, comment2)
      end
    end
  end
  