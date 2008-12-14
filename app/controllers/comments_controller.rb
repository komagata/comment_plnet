class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  # GET /comments.atom
  # GET /comments.js
  def index
    if params[:url].blank?
      @comments = Comment.all
      @title = "全てのコメント - Comment Plnet"
    elsif params[:url].class == String
      @comments = Comment.find(:all, :conditions => ["url = ?", params[:url]])
      @title = "#{params[:url]}のコメント - Comment Plnet"
    else
      @comments = Comment.find(:all, :conditions => ["url = ?", params[:url].join("/")])
      @title = "#{params[:url].join("/")}のコメント - Comment Plnet"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
      format.atom { render :layout => false }
      format.js   { render :json => @comments.to_json, :callback => params[:callback] }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  # GET /comments/1.js
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
      format.js   { render :json => @comment.to_json, :callback => params[:callback] }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to request.referer }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
