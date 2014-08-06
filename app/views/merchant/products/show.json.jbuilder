json.product do
    json.id @product.id
    json.name @product.name
    json.description @product.description
    json.price @product.price
    json.product_comments_count @product.product_comments_count
    json.product_likes_count @product.product_likes_count
    json.image_url @product.attachments.first.image_url
end
json.comments @product.product_comments
